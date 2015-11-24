function [] = MIG_fix_P2_onsets(sub)
% take input from asublist_fixonsets.txt
% edit column with test onset times (add 1.1 seconds)
% save this file 


% set file
dir = '~/Documents/MIG/';
file = [dir,sub,'/be/clean/P2/',sub,'-P2.txt'];

% read data
dat = tdfread(file,'\t');

% correct problem
dat.response_onset = dat.probe_onset(:) +1.1;

% save
tdfwrite(file,dat);



end

