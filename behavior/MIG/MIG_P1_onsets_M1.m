function [] = MIG_P1_onsets_M1(sub,trim)
% MIG Phase 1 behavior from text file output
% event related design with 1 second durations

% SUB:  string reflecting subject number (e.g., 'MIG-2722')
% TRIM: time to be trimmed off leadin in seconds (e.g., 8)

%%
% default trim
if (nargin < 2 || isempty(trim))
    trim = 0;
end

% set readin data file
dir = '~/Documents/MIG/';
file = [dir,sub,'/be/clean/P1/',sub,'-P1.txt'];

% readin data
dat = tdfread(file,'\t');

% trim onsets
dat.trial_onset = dat.trial_onset(:) - trim;

% local varibles
run = {'R1'; 'R2'};
condition = {'SF'; 'NF'; 'AF'; 'SC'};

%% fill onsets & print
for i = 1:length(run)        
    switch i
        case 1
            sad = dat.trial_onset(dat.cond_num == 1 & dat.block < 9);
            neutral = dat.trial_onset(dat.cond_num == 2 & dat.block < 9);
            scene = dat.trial_onset(dat.cond_num == 3 & dat.block < 9);
            face = dat.trial_onset((dat.cond_num == 1 | dat.cond_num == 2) & dat.block < 9);
        case 2
            sad = dat.trial_onset(dat.cond_num == 1 & dat.block >= 9);
            neutral = dat.trial_onset(dat.cond_num == 2 & dat.block >= 9);
            scene = dat.trial_onset(dat.cond_num == 3 & dat.block >= 9);
            face = dat.trial_onset((dat.cond_num == 1 | dat.cond_num == 2) & dat.block >= 9);
    end
    
    for j = 1:length(condition)
        switch j
            case 1; onsets = [sad ones(length(sad),2)];
            case 2; onsets = [neutral ones(length(neutral),2)];
            case 3; onsets = [face ones(length(face),2)];
            case 4; onsets = [scene ones(length(scene),2)];
        end
        
        % round to whole integer
        onsets = round(onsets);
        
        % place in unique folders
        subdir = [dir,sub,'/be/onsets/P1/'];
        rundir = [subdir,'M1/',run{i}];
        if exist(rundir,'dir') == 0
            mkdir(rundir);
        end
        filename = [rundir,'/',sub,'-',run(i),'-',condition(j),'.txt'];
        fileX = cellstr(cell2mat(filename));
        dlmwrite(fileX{1},onsets,'delimiter','\t','precision','%.4f');
    end % condition
end % run


end % function

