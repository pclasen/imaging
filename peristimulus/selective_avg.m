function timepoints=selective_avg(params)
% selective averaging for FSL feat analysis
% read in a 4-d analyze file
% compute selective average on all in-mask voxels
%
% required arguments:
% params: a struct containing details about analysis:
%     params.featdir: FEAT directory for analysis
%     params.ter - effective temporal resolution of analysis
%        - note: Image Processing  Toolbox is required for TER ~= TR
%     params.PosWindow - positive time window for averaging (default=24 s)
%     params.NegWindow - negative time window for averaging (default=4 s)
%     params.sed_converter - full path of designconvert.sed

%
% Russ Poldrack, 7/2/04
warning off MATLAB:divideByZero

if ~exist('params'),
 help analyze_roi
 return;
end;

if ~isfield(params,'featdir')
  help selective_avg
 return;
end;
featdir=params.featdir;

if ~isfield(params,'sed_converter'),
  SED_CONVERTER='/space/raid/fmri/bin/designconvert.sed';
else,
  SED_CONVERTER=params.sed_converter;
end;

% check that SED_CONVERTER exists
if ~exist(SED_CONVERTER,'file'),
  fprintf('%s does not exist!\n',SED_CONVERTER);
  return;
end;

% design: a cell matrix containing filenames for either SPM.mat file
% (for SPM analysis) or FSL 3-column onset files

% make sure featdir exists and has data in it

current_dir=pwd;
try,
  cd(featdir);
catch,
  fprintf('problem changing to featdir (%s)\n',featdir);
  return;
end;

% convert design.fsf to design.m
[s,w]=system(sprintf('sed -f %s design.fsf > design.m',SED_CONVERTER));
if s,
   fprintf('problem converting design.fsf to design.m\n');
  return;
end;

design_file=which('design');
fprintf('Loading design from:\n%s\n',design_file);
try,
  design;
catch,
   fprintf('problem loading design.m\n');
  return;
end;

% set up params and check fields

if ~isfield(params,'ter'),
  params.ter=fmri.tr;
end;

if ~isfield(params,'PosWindow'),
  params.PosWindow=24;
end;

if ~isfield(params,'NegWindow'),
  params.NegWindow=4;
end;


% load in analyze file
datafile=sprintf('%s/filtered_func_data.img',featdir);
fprintf('Loading filtered data from:\n%s\n',datafile);

try,
  [d,d_dims,d_scales]=read_avw(datafile);
catch,
  fprintf('error reading datafile %s\n',datafile);
  return;
end;

% load in mask file
maskfile=sprintf('%s/mask.img',featdir);
fprintf('Loading mask from:\n%s\n',datafile);

try,
  [mask,mask_dims]=read_avw(maskfile);
catch,
  fprintf('error reading mask file %s\n',datafile);
  return;
end;

% set up the design

TR=fmri.tr;
TER=params.ter;
ntp=fmri.npts;
roidata=zeros(1,ntp);

% make sure image processing toolbox is available if needed

if isempty(which('resample')) & TER ~= TR,
  fprintf('Image Processing Toolbox is necessary for subsampling\n');
  fprintf('Setting TER = TR...\n');
  TER=TR;
end;

% if TER is shorter than TR, oversample data (with lowpass filtering)

if TER ~= TR,
  if mod(TR,TER),
    trmult=TR/TER;
    TER=TR/round(trmult);
    fprintf('TR must be an even multiple of TER: changing TER to %0.3f\n', ...
            TER);
  end;
  roidata=resample(roidata,TR/TER,1);
end;

% set up FIR model

PosWindow=params.PosWindow;
NegWindow=params.NegWindow;
NPosEst=round(PosWindow/TER);
NNegEst=round(NegWindow/TER);
nHEst=NPosEst + NNegEst;

% determine how many conditions there are

nconds=fmri.evs_orig;
timepoints=zeros(nconds,nHEst);

% fix the structures so that the index is not in the name
fields_to_fix={ 'shape' 'convolve' 'convolve_phase' ...
    'tempfilt_yn' 'deriv_yn' 'custom' 'gammasigma' 'gammadelay' ...
    'ortho'};

for c=1:nconds,
 for f=1:length(fields_to_fix),
   if isfield(fmri,sprintf('%s%d',fields_to_fix{f},c)),
     cmd=sprintf('fmri.%s(%d)={fmri.%s%d};',fields_to_fix{f},c,fields_to_fix{f},c);
    eval(cmd);
  end;
 end;
end;



% load in the onsets
% right now assume single-column input, deal with 3-column files later

ons=cell(1,nconds);
for c=1:nconds,
  if fmri.shape{c}==2, % single-column file
    fprintf('Loading condition %d onsets (single-column format):\n%s\n',...
            c,fmri.custom{c});
    [p1,p2,p3]=fileparts(fmri.custom{c});
    fmri.condname{c}=p2;
    fmri.sf(c)={load(fmri.custom{c})};
    % need to subtract off TR to get back to zero time origin
    fmri.ons{c}=find(fmri.sf{c})*fmri.tr - fmri.tr;
  elseif fmri.shape{c}==3, % 3-column format
    fprintf('Loading condition %d onsets (3-column format):\n%s\n',c,fmri.custom{c});
    tmp=load(fmri.custom{c});
    fmri.ons{c} = tmp(:,1);
    [p1,p2,p3]=fileparts(fmri.custom{c});
    fmri.condname{c}=p2;
  end;
end;


SCM=[];
ntp=round(ntp*(TR/TER));



for conds=1:nconds,
    % this code is based on spm_roi_fir_desmtx.m, which was in turn based on
    % from from Doug Greve at MGH

    rounded_onsets=round(fmri.ons{conds}/TER)*TER; % find nearest TR for each onset
    Par=zeros(ntp,2);
    Par(:,1)=[0:TER:(ntp-1)*TER]';
    for trial=1:length(rounded_onsets),
      Par(find(Par(:,1)==rounded_onsets(trial)),2)=1;
    end;
    tMax=(ntp-1)*TER;
    nPreStim=floor(NegWindow/TER);
    tTR = [0:TER:tMax];
    iStimIndex = find( Par(:,2) == 1 ); % get indices for this condition
    tPres = Par(iStimIndex,1);
    iok = find(tPres >= 0 & tPres <= tMax);
    tPres = tPres(iok);
    nPres = hist(tPres,tTR);
    % construct the conv mtx for this Stimulus Type %
    c1 = zeros(1,nHEst);
    Pulses = [nPres zeros(1,nPreStim) ];
    c1(1) = Pulses(1);
    E = toeplitz(Pulses,c1);
    X=[];
    % add to global conv mtx %
    X = cat(2,X,E);

    if(nPreStim ~= 0)
      X = X(1+nPreStim:ntp+nPreStim,:);
    end
    SCM=[SCM X];
    p=Par(:,2);
    save(sprintf('c%d_fsl.txt',conds),'p','-ASCII');

end;

% add column of ones to model non-zero mean
SCM=[SCM ones(length(SCM),1)];

% normalize non-unit columns in desmtx

for r=1:size(SCM,2)-1,
    SCM(:,r)=SCM(:,r)-mean(SCM(:,r));
end;

% estimate the model for each voxel in the mask


timepoints=zeros(d_dims(1),d_dims(2),d_dims(3),nconds,nHEst);
fprintf('Percent done: ');
for x=1:d_dims(1),
  fprintf('%d.',round(100*x/d_dims(1)));
  for y=1:d_dims(2),
    for z=1:d_dims(3),

      if ~mask(x,y,z),
        continue;
      end;
      % normalize to mean 100
      tmp=d(x,y,z,:);
      roidata=(tmp - mean(tmp))/mean(tmp);
      roidata=squeeze(roidata);
      b_est=pinv(SCM)*roidata';


      % reshape b_est into separate conditions

      for c=1:nconds,
         range_st=(c-1)*nHEst + 1;
         range_end=c*nHEst;
         timepoints(x,y,z,c,:)=b_est(range_st:range_end)';
      end;

  end;
 end;
end;

% save the data
if ~exist('roi','dir'),
  mkdir(featdir,'roi');
end;
if ~exist('reg/roi','dir'),
  mkdir([featdir '/reg'],'roi');
end;

fprintf('Saving data (including registered versions)');
for c=1:nconds,
  outfile=sprintf('roi/%s.img',fmri.condname{c});
  save_avw(squeeze(timepoints(:,:,:,c,:)),outfile,'f',[d_scales(1:3)' fmri.tr]);
  % create registered version
  if exist(sprintf('%s/reg_standard',featdir),'dir'),
    cmd=sprintf('applyxfm4D %s %s/reg_standard/example_func.img %s/reg/%s %s/reg/example_func2standard.mat -singlematrix',...
    outfile,featdir,featdir,outfile,featdir);
    fprintf('.');
    unix(cmd);
  end;
end;
fprintf('\n\n');

