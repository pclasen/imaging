function [] = RAP_onsets_M1(sub,trim)
% RAP behavior from .mat file 
% event related design with 1 second durations

%% Trim 

% default trim
if (nargin < 2 || isempty(trim))
    trim = 0;
end

% set directories
dir = '~/Documents/RAP';
file = [dir,sub,'be/',sub,'.mat']; % need to change file names 

% read in data
dat = matfile(file);

% apply trim
dat.trial_onsets = dat.trial_onsets - trim;

%% generate custom EV text files (3 column) for FSL FEAT
event = {'c','a','i','r','t'};
valence = {'NEG','NEU','POS'}'
for i = 1:length(event);
    for j = 1:length(valence);
        condition = {event{i},valence{j}};
    end
end

% by run
for i = 1:4
    




end % function

