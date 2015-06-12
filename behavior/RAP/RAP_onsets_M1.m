function [] = RAP_onsets_M1(sub,trim)
% RAP behavior from .mat file 
% event related design with epochs matching durations

%% Trim 

% default trim
if (nargin < 2 || isempty(trim))
    trim = 0;
end

% set directories
dir = '~/Documents/RAP/';
file = [dir,sub,'/be/clean/',sub,'.txt']; 

% read in data
% dat = matfile(file);
dat = tdfread(file,'\t');

% convert valence to cell array
valence = cellstr(dat.valence);
val = unique(valence);

% apply trim
cueTrim = dat.cue - trim;
d1Trim = dat.delay1 - trim;
imageTrim = dat.image - trim;
d2Trim = dat.delay2 - trim;
rateTrim = dat.rate - trim;


%% generate custom EV text files (3 column) for FSL FEAT
condition = {'C2+';'C2-';'C2o';'D1+';'D1-';'D1o';'I2+';'I2-';'I2o';'D2+';'D2-';'D2o';'R+';'R-';'Ro'};

for i = 1:4 % one for each run
    for j = 1:length(val)
        cue.(val{j}) = cueTrim(strcmp(val{j},valence) & ~isnan(cueTrim) & dat.block == i);
        d1.(val{j}) = d1Trim(strcmp(val{j},valence) & ~isnan(d1Trim) & dat.block == i);
        image.(val{j}) = imageTrim(strcmp(val{j},valence) & ~isnan(imageTrim) & dat.block == i);
        d2.(val{j}) = d2Trim(strcmp(val{j},valence) & ~isnan(d2Trim) & dat.block == i);
        rate.(val{j}) = rateTrim(strcmp(val{j},valence) & ~isnan(rateTrim) & dat.block == i);
        
        % rating (1 = pos; -1 = neg; 0 = neutral; -99 = no response)
        noResp.(val{j})(i,1) = length(dat.rating(dat.rating==-99 & strcmp(val{j},valence) & dat.block == i));
        
        % isloate ratings per valence per run
        ratingValence = dat.rating(strcmp(val{j},valence) & ~isnan(dat.rating) & dat.block == i);
        
        if strcmp('positive',val{j}) == 1
            valCompare = ones(length(ratingValence),1);
        elseif strcmp('negative',val{j}) == 1
            valCompare = ones(length(ratingValence),1)*-1;
        elseif strcmp('neutral',val{j}) == 1
            valCompare = zeros(length(ratingValence),1);
        end
         
        compare = mean(ratingValence==valCompare);
        coherence.(val{j})(i,1) = compare;
                    
    end
    
    for g = 1:length(condition)
        switch g         
            case 1; onsets = [cue.positive repmat([2 1],length(cue.positive),1)];
            case 2; onsets = [cue.negative repmat([2 1],length(cue.negative),1)];
            case 3; onsets = [cue.neutral repmat([2 1],length(cue.neutral),1)];
            case 4; onsets = [d1.positive repmat([4 1],length(d1.positive),1)];
            case 5; onsets = [d1.negative repmat([4 1],length(d1.negative),1)];
            case 6; onsets = [d1.neutral repmat([4 1],length(d1.neutral),1)];
            case 7; onsets = [image.positive repmat([2 1],length(image.positive),1)];
            case 8; onsets = [image.negative repmat([2 1],length(image.negative),1)];
            case 9; onsets = [image.neutral repmat([2 1],length(image.neutral),1)];
            case 10; onsets = [d2.positive repmat([4 1],length(d2.positive),1)];
            case 11; onsets = [d2.negative repmat([4 1],length(d2.negative),1)];
            case 12; onsets = [d2.neutral repmat([4 1],length(d2.neutral),1)];
            case 13; onsets = [rate.positive repmat([2 1],length(rate.positive),1)];
            case 14; onsets = [rate.negative repmat([2 1],length(rate.negative),1)];
            case 15; onsets = [rate.neutral repmat([2 1],length(rate.neutral),1)];
        end
   
        % round to whole integer
        onsets = round(onsets);
        
        % place onsets in unique run folders
        subdir = [dir,sub,'/be/onsets/M1/'];
        rundir = [subdir,'/R',int2str(i)];
        if exist(rundir,'dir') == 0
            mkdir(rundir);
        end
        filename = [rundir,'/',sub,'_','R',int2str(i),'_',condition(g),'.txt'];
        fileX = cellstr(cell2mat(filename));
        dlmwrite(fileX{1},onsets,'delimiter','\t','precision','%.4f');
        clear filename fileX
           
    end % condition
    
end % run

% matrix for non-respones and coherence
dsNR = struct2dataset(noResp);
dsCoh = struct2dataset(coherence);

% write non-response and coherence data to files
subdir = [dir,sub,'/be/onsets/'];

filename = [subdir,sub,'-nonresponses','.txt'];
if exist(filename,'file') == 0
    export(dsNR,'file',filename,'delimiter','\t');
end
clear filename

filename = [subdir,sub,'-coherence','.txt'];
if exist(filename,'file') == 0
    export(dsCoh,'file',filename,'delimiter','\t');
end
clear filename




end % function

