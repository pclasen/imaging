function [] = MIG_P2_onsets_M1(sub,trim)
% MIG Phase 2 behavior from text file output
% onsets with 1 second durations

% SUB:  string reflecting subject number (e.g., 'MIG-2722')
% TRIM: time to be trimmed off leadin in seconds (e.g., 8)

%%
% default trim
if (nargin < 2 || isempty(trim))
    trim = 0;
end

% set readin data file
dir = '~/Documents/MIG/';
file = [dir,sub,'/be/clean/P2/',sub,'-P2.txt'];

% readin data
dat = tdfread(file,'\t');

% trim all onsets 
target = dat.trial_onset(:) - trim;
delayA = dat.delayA_onset(:) - trim;
delayB = dat.delayB_onset(:) - trim;
probe = dat.probe_onset(:) - trim;
response = dat.response_onset(:) - trim;

% convert string arrays to cells
cond = cellstr(dat.cond);
type = cellstr(dat.type);

% local variables
kind = unique(type);
face = unique(cond);

condition = {'TstSF'; 'TstNF'; 'TswSF'; 'TswNF'; 'DAstSF'; 'DAstNF'; 'DAswSF'; 'DAswNF';...
    'DBSF'; 'DBNF'; 'PstSF'; 'PstNF'; 'PswSF'; 'PswNF'; 'RstSF'; 'RstNF'; 'RswSF'; 'RswNF'};

%% fill onsets & print
for i = 1:8 % one for each run
    for j = 1:length(kind)
        for g = 1:length(face)
            targ.(kind{j}).(face{g}) = target(strcmp(kind{j},type) & strcmp(face{g},cond) & dat.block == i);
            delA.(kind{j}).(face{g}) = delayA(strcmp(kind{j},type) & strcmp(face{g},cond) & dat.block == i);
            if strcmp('switch',kind{j}) == 1
                delB.(face{g}) = delayB(strcmp(face{g},cond) & dat.block == i);
                delB.(face{g}) = delB.(face{g})(~isnan(delB.(face{g})));
            end
            rsvp.(kind{j}).(face{g}) = probe(strcmp(kind{j},type) & strcmp(face{g},cond) & dat.block == i);
            test.(kind{j}).(face{g}) = response(strcmp(kind{j},type) & strcmp(face{g},cond) & dat.block == i);
        end
    end
    
    % create individual text files with 3 column format
    for j = 1:length(condition)
        switch j
            case 1; onsets = [targ.stay.sad ones(length(targ.stay.sad),2)];
            case 2; onsets = [targ.stay.neutral ones(length(targ.stay.neutral),2)];
            case 3; onsets = [targ.switch.sad ones(length(targ.switch.sad),2)];
            case 4; onsets = [targ.switch.neutral ones(length(targ.switch.neutral),2)];
            case 5; onsets = [delA.stay.sad ones(length(delA.stay.sad),2)];
            case 6; onsets = [delA.stay.neutral ones(length(delA.stay.neutral),2)];
            case 7; onsets = [delA.switch.sad ones(length(delA.switch.sad),2)];
            case 8; onsets = [delA.switch.neutral ones(length(delA.switch.neutral),2)];
            case 9; onsets = [delB.sad ones(length(delB.sad),2)];
            case 10; onsets = [delB.neutral ones(length(delB.neutral),2)];
            case 11; onsets = [rsvp.stay.sad ones(length(rsvp.stay.sad),2)];
            case 12; onsets = [rsvp.stay.neutral ones(length(rsvp.stay.neutral),2)];
            case 13; onsets = [rsvp.switch.sad ones(length(rsvp.switch.sad),2)];
            case 14; onsets = [rsvp.switch.neutral ones(length(rsvp.switch.neutral),2)];
            case 15; onsets = [test.stay.sad ones(length(test.stay.sad),2)];
            case 16; onsets = [test.stay.neutral ones(length(test.stay.neutral),2)];
            case 17; onsets = [test.switch.sad ones(length(test.switch.sad),2)];
            case 18; onsets = [test.switch.neutral ones(length(test.switch.neutral),2)];
        end
        
        % round to whole integer
        % % onsets = round(onsets);
        
        % place onsets in unique run folders
        subdir = [dir,sub,'/be/onsets/P2/'];
        rundir = [subdir,'M1/R',int2str(i)];
        if exist(rundir,'dir') == 0
            mkdir(rundir);
        end
        filename = [rundir,'/',sub,'-','R',int2str(i),'-',condition(j),'.txt'];
        fileX = cellstr(cell2mat(filename));
        dlmwrite(fileX{1},onsets,'delimiter','\t','precision','%.4f');
        
    end % condition
end % run


end % function

