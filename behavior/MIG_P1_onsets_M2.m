function [] = MIG_P1_onsets_M2(sub,trim)
% MIG Phase 1 behavior from text file output
% block design

% SUB:  string reflecting subject number (e.g., 'MIG-2722')
% TRIM: time to be trimmed off leadin in seconds (e.g., 8)

%%
% default trim
% NOTE: lag varialbe (for onsets) is free of added lead in time
% NOTE: so we have to adjust it accordingly
if (nargin < 2 || isempty(trim))
    trimFix = 10;
else
    trimFix = 10 - trim;
end

% set readin data file
dir = '~/Documents/MIG/';
file = [dir,sub,'/be/clean/P1/',sub,'-P1.txt'];

% readin data
dat = tdfread(file,'\t');

% trim onsets
dat.lag = dat.lag(:) + trimFix;

% local varibles
run = {'R1'; 'R2'};
condition = {'SF'; 'NF'; 'AF'; 'SC'};

%% fill onsets & print
for i = 1:length(run)
    % get block onset indices
    blockOn = [];
    for k = 1:15
        onBlock = find(dat.block==k,1,'first');
        blockOn = [blockOn;onBlock];
    end
    dat.blockOn = zeros(length(dat.lag),1);
    dat.blockOn(blockOn) = 1;
    
    % get onsets by run
    switch i
        case 1
            sad = dat.lag(dat.blockOn == 1 & dat.cond_num == 1 & dat.block < 9);
            neutral = dat.lag(dat.blockOn == 1 & dat.cond_num == 2 & dat.block < 9);
            scene = dat.lag(dat.blockOn == 1 & dat.cond_num == 3 & dat.block < 9);
            face = dat.lag(dat.blockOn == 1 & (dat.cond_num == 1 | dat.cond_num == 2) & dat.block < 9);
        case 2
            sad = dat.lag(dat.blockOn == 1 & dat.cond_num == 1 & dat.block >= 9);
            neutral = dat.lag(dat.blockOn == 1 & dat.cond_num == 2 & dat.block >= 9);
            scene = dat.lag(dat.blockOn == 1 & dat.cond_num == 3 & dat.block >= 9);
            face = dat.lag(dat.blockOn == 1 & (dat.cond_num == 1 | dat.cond_num == 2) & dat.block >= 9);
    end
    
    for j = 1:length(condition)
        switch j
            case 1; onsets = [sad repmat([40,1],length(sad),1)];
            case 2; onsets = [neutral repmat([40,1],length(neutral),1)];
            case 3; onsets = [face repmat([40,1],length(face),1)];
            case 4; onsets = [scene repmat([40,1],length(scene),1)];
        end
        
        % round to whole integer
        onsets = round(onsets);
        
        % place in unique folders
        subdir = [dir,sub,'/be/onsets/P1/'];
        rundir = [subdir,'M2/',run{i}];
        if exist(rundir,'dir') == 0
            mkdir(rundir);
        end
        filename = [rundir,'/',sub,'-',run(i),'-',condition(j),'.txt'];
        fileX = cellstr(cell2mat(filename));
        dlmwrite(fileX{1},onsets,'delimiter','\t','precision','%.4f');
    end % condition
end % run


end % function

