function [] = MIGP2_peristim_ts(list,roi)
%compute peri-stimulus timecourse for FEAT fMRI data
%   using R.Poldrack subroutines


    dir = '~/Documents/MIG/';
    
    % import subject list & parse by group
   
    % define condition/run vectors
    cond = {'sad';'neutral'};
    run = {'R1';'R2';'R3';'R4';'R5';'R6';'R7';'R8'};

    for g=1:length(list)
                
        for i=1:length(cond)
            
            ts.(cond{i}) = [];
            ts.mean.(cond{i}) = [];
            ts.std.(cond{i}) = [];
            
            for j=1:length(run);

                params.featdir = [dir,sub,'feat/P2/M2/glm/',j,'.feat'];
                params.ClusterInStandardSpace = [dir,'group/ROIs/',roi,'.nii.gz'];

                cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond11']; % make condition variable (i)
                roi_img = params.ClusterInStandardSpace;
                ts.(cond{i})(j,:) = extract_clust_ts(cond_avg_img, roi_img);

            end % run

            ts.mean.(cond{i})(g,:) = mean(ts.(cond{i}),1);
            ts.std.(cond{i})(g,:) = std(ts.(cond{i}),1);

        end % condition
        
    end % list


end % function

