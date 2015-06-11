function [] = RAP_onsets(sub,trim)
% RAP behavior from .mat file 
% event related design with 1 second durations

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
cue = dat.cue - trim;
d1 = dat.delay1 - trim;
image = dat.image - trim;
d2 = dat.delay2 - trim;
rate = dat.rate - trim;


%% generate custom EV text files (3 column) for FSL FEAT
condition = {'C2+';'C2-';'C2o';'D1+';'D1-';'D1o';'I2+';'I2-';'I2o';'D2+';'D2-';'D2o';'R+';'R-';'Ro';'C6+';'C6-';'C6o';'I6+';'I6-';'I6o'};

for i = 1:4 % one for each run
    for j = 1: length(val)
        cue.(val{j}) = cue(strcmp(val{j},valence) & ~isnan(cue) & dat.block == i);
        d1.(val{j}) = d1(strcmp(val{j},valence) & ~isnan(d1) & dat.block == i);
        image.(val{j}) = image(strcmp(val{j},valence) & ~isnan(image) & dat.block == i);
        d2.(val{j}) = d2(strcmp(val{j},valence) & ~isnan(d2) & dat.block == i);
        rate.(val{j}) = rate(strcmp(val{j},valence) & ~isnan(rate) & dat.block == i);
        if strcmp('positive',val{j} == 1
        elseif strcmp('negative',val{j} == 1
        elseif strcmp('neutral',val{j} == 1
        end
                    
    end
    
    for g = 1:length(condition)
        switch j         
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
            case 16; onsets = [cue.positive repmat([6 1],length(cue.positive),1)];
            case 17; onsets = [cue.negative repmat([6 1],length(cue.negative),1)];
            case 18; onsets = [cue.neutral repmat([6 1],length(cue.neutral),1)];
            case 19; onsets = [image.positive repmat([6 1],length(image.positive),1)];
            case 20; onsets = [image.negative repmat([6 1],length(image.negative),1)];
            case 21; onsets = [image.neutral repmat([6 1],length(image.neutral),1)];
        end
   
        % round to whole integer
        onsets = round(onsets);
        
        % place onsets in unique run folders
        subdir = [dir,sub,'/be/onsets/'];
        rundir = [subdir,'/R',int2str(i)];
        if exist(rundir,'dir') == 0
            mkdir(rundir);
        end
        filename = [rundir,'/',sub,'_','R',int2str(i),'_',condition(j),'.txt'];
        fileX = cellstr(cell2mat(filename));
        dlmwrite(fileX{1},onsets,'delimiter','\t','precision','%.4f');
        
    end % condition
end % run
    




end % function

