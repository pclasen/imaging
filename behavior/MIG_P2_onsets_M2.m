function [] = MIG_P2_onsets_M2(sub,trim)
% MIG Phase 2 behavior from text file output
% onsets with variable durations (mirror actual event duration)

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
            case 1; onsets = [targ.stay.sad repmat([4 1],length(targ.stay.sad),1)];
            case 2; onsets = [targ.stay.neutral repmat([4 1],length(targ.stay.neutral),1)];
            case 3; onsets = [targ.switch.sad repmat([4 1],length(targ.switch.sad),1)];
            case 4; onsets = [targ.switch.neutral repmat([4 1],length(targ.switch.neutral),1)];
            case 5; onsets = [delA.stay.sad repmat([8 1],length(delA.stay.sad),1)];
            case 6; onsets = [delA.stay.neutral repmat([8 1],length(delA.stay.neutral),1)];
            case 7; onsets = [delA.switch.sad repmat([8 1],length(delA.switch.sad),1)];
            case 8; onsets = [delA.switch.neutral repmat([8 1],length(delA.switch.neutral),1)];
            case 9; onsets = [delB.sad repmat([8 1],length(delB.sad),1)];
            case 10; onsets = [delB.neutral repmat([8 1],length(delB.neutral),1)];
            case 11; onsets = [rsvp.stay.sad repmat([1.1 1],length(rsvp.stay.sad),1)];
            case 12; onsets = [rsvp.stay.neutral repmat([1.1 1],length(rsvp.stay.neutral),1)];
            case 13; onsets = [rsvp.switch.sad repmat([1.1 1],length(rsvp.switch.sad),1)];
            case 14; onsets = [rsvp.switch.neutral repmat([1.1 1],length(rsvp.switch.neutral),1)];
            case 15; onsets = [test.stay.sad repmat([.9 1],length(test.stay.sad),1)];
            case 16; onsets = [test.stay.neutral repmat([.9 1],length(test.stay.neutral),1)];
            case 17; onsets = [test.switch.sad repmat([.9 1],length(test.switch.sad),1)];
            case 18; onsets = [test.switch.neutral repmat([.9 1],length(test.switch.neutral),1)];
        end
        
        % round to whole integer
        % % onsets = round(onsets);
        
        % place onsets in unique run folders
        subdir = [dir,sub,'/be/onsets/P2/'];
        rundir = [subdir,'M2R',int2str(i)];
        if exist(rundir,'dir') == 0
            mkdir(rundir);
        end
        filename = [rundir,'/',sub,'-','R',int2str(i),'-',condition(j),'.txt'];
        fileX = cellstr(cell2mat(filename));
        dlmwrite(fileX{1},onsets,'delimiter','\t','precision','%.4f');
        
    end % condition
end % run


end % function

