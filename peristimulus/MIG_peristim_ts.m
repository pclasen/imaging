function [] = MIG_peristim_ts(study,phase,model,sub,roi)
%compute peri-stimulus timecourse for FEAT fMRI data
%   using R.Poldrack subroutines


    dir = '~/Documents/MIG/';
    
    params.featdir = [dir,sub,'feat/analysis/run1.feat'];
    params.ClusterInStandardSpace = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_group_12subs/ROI_analysis/',roi,'.nii.gz'];

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond11'];
        roi_img = params.ClusterInStandardSpace;
        ts1=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond12'];
        roi_img = params.ClusterInStandardSpace;
        ts2=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond22'];
        roi_img = params.ClusterInStandardSpace;
        ts3=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond99'];
        roi_img = params.ClusterInStandardSpace;
        ts4=extract_clust_ts(cond_avg_img, roi_img);
        
           ts_all=[ts1;ts2;ts3;ts4;ts5;ts6;ts7;ts8];
        cond11=[ts1;ts5];
        cond12=[ts2;ts6];
        cond22=[ts3;ts7];
        cond99=[ts4;ts8];
    
    %creat raw data 2D vector
    eval(['TS_ALL_',int2str(a),'= [ts_all]']);
    
    %create mean time series by condition
    mc11=mean(cond11,1);
    mc12=mean(cond12,1);
    mc22=mean(cond22,1);
    mc99=mean(cond99,1);

    %creates subject vectors with mean time point means by condition
    eval(['Mean_sub',int2str(a),'=[mc11;mc12;mc22;mc99]']);
        



end

