%function batch_clusterout_allsubs(clusternum)
%batch_clusterout : compute peri-stimulus timecourse for FEAT fMRI data



roi = ['decnegGscram_IFG_rht_MFG'];%change to match mask name (w/o .nii.gz)

%2run_1_2
for a = [28 32]
    %for a = [1]
    params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run1.feat'];
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

    params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run2.feat'];
    params.ClusterInStandardSpace = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_group_12subs/ROI_analysis/',roi,'.nii.gz'];

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond11'];
        roi_img = params.ClusterInStandardSpace;
        ts5=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond12'];
        roi_img = params.ClusterInStandardSpace;
        ts6=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond22'];
        roi_img = params.ClusterInStandardSpace;
        ts7=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond99'];
        roi_img = params.ClusterInStandardSpace;
        ts8=extract_clust_ts(cond_avg_img, roi_img);

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

end%2run_1_2

%2run_1_3
for a = [21]
    %for a = [1]
    params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run1.feat'];
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

    params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run3.feat'];
    params.ClusterInStandardSpace = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_group_12subs/ROI_analysis/',roi,'.nii.gz'];

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond11'];
        roi_img = params.ClusterInStandardSpace;
        ts5=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond12'];
        roi_img = params.ClusterInStandardSpace;
        ts6=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond22'];
        roi_img = params.ClusterInStandardSpace;
        ts7=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond99'];
        roi_img = params.ClusterInStandardSpace;
        ts8=extract_clust_ts(cond_avg_img, roi_img);


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

    %creates subject vectors with mean time points by condition
    eval(['Mean_sub',int2str(a),'=[mc11;mc12;mc22;mc99]']);

end%2run_1_3

%3run_1_2_3
for a = [18 22 23]
    %for a = [1]
    params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run1.feat'];
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

    params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run2.feat'];
    params.ClusterInStandardSpace = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_group_12subs/ROI_analysis/',roi,'.nii.gz'];

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond11'];
        roi_img = params.ClusterInStandardSpace;
        ts5=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond12'];
        roi_img = params.ClusterInStandardSpace;
        ts6=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond22'];
        roi_img = params.ClusterInStandardSpace;
        ts7=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond99'];
        roi_img = params.ClusterInStandardSpace;
        ts8=extract_clust_ts(cond_avg_img, roi_img);

    params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run3.feat'];
    params.ClusterInStandardSpace = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_group_12subs/ROI_analysis/',roi,'.nii.gz'];

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond11'];
        roi_img = params.ClusterInStandardSpace;
        ts9=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond12'];
        roi_img = params.ClusterInStandardSpace;
        ts10=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond22'];
        roi_img = params.ClusterInStandardSpace;
        ts11=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond99'];
        roi_img = params.ClusterInStandardSpace;
        ts12=extract_clust_ts(cond_avg_img, roi_img);

    ts_all=[ts1;ts2;ts3;ts4;ts5;ts6;ts7;ts8;ts9;ts10;ts11;ts12];
        cond11=[ts1;ts5;ts9];
        cond12=[ts2;ts6;ts10];
        cond22=[ts3;ts7;ts11];
        cond99=[ts4;ts8;ts12];
        
    %creat raw data 2D vector
    eval(['TS_ALL_',int2str(a),'= [ts_all]']);

    %create mean time series by condition
    mc11=mean(cond11,1);
    mc12=mean(cond12,1);
    mc22=mean(cond22,1);
    mc99=mean(cond99,1);

    %creates subject vectors with mean time points by condition
    eval(['Mean_sub',int2str(a),'=[mc11;mc12;mc22;mc99]']);

end%3run_1_2_3

%3run_1_2_4
for a = [24]
    %for a = [1]
    params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run1.feat'];
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

    params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run2.feat'];
    params.ClusterInStandardSpace = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_group_12subs/ROI_analysis/',roi,'.nii.gz'];

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond11'];
        roi_img = params.ClusterInStandardSpace;
        ts5=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond12'];
        roi_img = params.ClusterInStandardSpace;
        ts6=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond22'];
        roi_img = params.ClusterInStandardSpace;
        ts7=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond99'];
        roi_img = params.ClusterInStandardSpace;
        ts8=extract_clust_ts(cond_avg_img, roi_img);

    params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run4.feat'];
    params.ClusterInStandardSpace = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_group_12subs/ROI_analysis/',roi,'.nii.gz'];

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond11'];
        roi_img = params.ClusterInStandardSpace;
        ts9=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond12'];
        roi_img = params.ClusterInStandardSpace;
        ts10=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond22'];
        roi_img = params.ClusterInStandardSpace;
        ts11=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond99'];
        roi_img = params.ClusterInStandardSpace;
        ts12=extract_clust_ts(cond_avg_img, roi_img);

    ts_all=[ts1;ts2;ts3;ts4;ts5;ts6;ts7;ts8;ts9;ts10;ts11;ts12];
        cond11=[ts1;ts5;ts9];
        cond12=[ts2;ts6;ts10];
        cond22=[ts3;ts7;ts11];
        cond99=[ts4;ts8;ts12];
        
    %creat raw data 2D vector
    eval(['TS_ALL_',int2str(a),'= [ts_all]']);

    %create mean time series by condition
    mc11=mean(cond11,1);
    mc12=mean(cond12,1);
    mc22=mean(cond22,1);
    mc99=mean(cond99,1);

    %creates subject vectors with mean time points by condition
    eval(['Mean_sub',int2str(a),'=[mc11;mc12;mc22;mc99]']);

end%3run_1_2_4

%4run
for a = [25 26 29 30 31]
    %for a = [1]
    params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run1.feat'];
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

    params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run2.feat'];
    params.ClusterInStandardSpace = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_group_12subs/ROI_analysis/',roi,'.nii.gz'];

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond11'];
        roi_img = params.ClusterInStandardSpace;
        ts5=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond12'];
        roi_img = params.ClusterInStandardSpace;
        ts6=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond22'];
        roi_img = params.ClusterInStandardSpace;
        ts7=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond99'];
        roi_img = params.ClusterInStandardSpace;
        ts8=extract_clust_ts(cond_avg_img, roi_img);

    params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run3.feat'];
    params.ClusterInStandardSpace = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_group_12subs/ROI_analysis/',roi,'.nii.gz'];

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond11'];
        roi_img = params.ClusterInStandardSpace;
        ts9=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond12'];
        roi_img = params.ClusterInStandardSpace;
        ts10=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond22'];
        roi_img = params.ClusterInStandardSpace;
        ts11=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond99'];
        roi_img = params.ClusterInStandardSpace;
        ts12=extract_clust_ts(cond_avg_img, roi_img);

    params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run4.feat'];
    params.ClusterInStandardSpace = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_group_12subs/ROI_analysis/',roi,'.nii.gz'];

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond11'];
        roi_img = params.ClusterInStandardSpace;
        ts13=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond12'];
        roi_img = params.ClusterInStandardSpace;
        ts14=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond22'];
        roi_img = params.ClusterInStandardSpace;
        ts15=extract_clust_ts(cond_avg_img, roi_img);

    cond_avg_img = [params.featdir filesep 'reg' filesep 'roi'  filesep 'cond99'];
        roi_img = params.ClusterInStandardSpace;
        ts16=extract_clust_ts(cond_avg_img, roi_img);

    ts_all=[ts1;ts2;ts3;ts4;ts5;ts6;ts7;ts8;ts9;ts10;ts11;ts12;ts13;ts14;ts15;ts16];
        cond11=[ts1;ts5;ts9;ts13];
        cond12=[ts2;ts6;ts10;ts14];
        cond22=[ts3;ts7;ts11;ts15];
        cond99=[ts4;ts8;ts12;ts16];

    %creat raw data 2D vector
    eval(['TS_ALL_',int2str(a),'= [ts_all]']);
    
    %create mean time series by condition
    mc11=mean(cond11,1);
    mc12=mean(cond12,1);
    mc22=mean(cond22,1);
    mc99=mean(cond99,1);

    %create subject vectors with mean time points by condition
    eval(['Mean_sub',int2str(a),'=[mc11;mc12;mc22;mc99]']);

end%4run

%Create raw data 2D Matrix across subjects
    raw_data = cat(1,TS_ALL_18,TS_ALL_21,TS_ALL_22,TS_ALL_23,TS_ALL_24,TS_ALL_25,TS_ALL_26,TS_ALL_28,TS_ALL_29,TS_ALL_30,TS_ALL_31,TS_ALL_32);
    %add sub headers and title headers
    sub_header = [18,1,11;18,1,12;18,1,22;18,1,99;18,2,11;18,2,12;18,2,22;18,2,99;18,3,11;18,3,12;18,3,22;18,3,99;...
        21,1,11;21,1,12;21,1,22;21,1,99;21,3,11;21,3,12;21,3,22;21,3,99;...
        22,1,11;22,1,12;22,1,22;22,1,99;22,2,11;22,2,12;22,2,22;22,2,99;22,3,11;22,3,12;22,3,22;22,3,99;...
        23,1,11;23,1,12;23,1,22;23,1,99;23,2,11;23,2,12;23,2,22;23,2,99;23,3,11;23,3,12;23,3,22;23,3,99;...
        24,1,11;24,1,12;24,1,22;24,1,99;24,2,11;24,2,12;24,2,22;24,2,99;24,4,11;24,4,12;24,4,22;24,4,99;...
        25,1,11;25,1,12;25,1,22;25,1,99;25,2,11;25,2,12;25,2,22;25,2,99;25,3,11;25,3,12;25,3,22;25,3,99;25,4,11;25,4,12;25,4,22;25,4,99;...
        26,1,11;26,1,12;26,1,22;26,1,99;26,2,11;26,2,12;26,2,22;26,2,99;26,3,11;26,3,12;26,3,22;26,3,99;26,4,11;26,4,12;26,4,22;26,4,99;...
        28,1,11;28,1,12;28,1,22;28,1,99;28,2,11;28,2,12;28,2,22;28,2,99;...
        29,1,11;29,1,12;29,1,22;29,1,99;29,2,11;29,2,12;29,2,22;29,2,99;29,3,11;29,3,12;29,3,22;29,3,99;29,4,11;29,4,12;29,4,22;29,4,99;...
        30,1,11;30,1,12;30,1,22;30,1,99;30,2,11;30,2,12;30,2,22;30,2,99;30,3,11;30,3,12;30,3,22;30,3,99;30,4,11;30,4,12;30,4,22;30,4,99;...
        31,1,11;31,1,12;31,1,22;31,1,99;31,2,11;31,2,12;31,2,22;31,2,99;31,3,11;31,3,12;31,3,22;31,3,99;31,4,11;31,4,12;31,4,22;31,4,99;...
        32,1,11;32,1,12;32,1,22;32,1,99;32,2,11;32,2,12;32,2,22;32,2,99];
    raw_data_cat = cat(2,sub_header,raw_data);
    title_header = [1 1 1 -6 -4 -2 0 2 4 6 8 10 12 14 16];
    Raw_Data = cat(1,title_header,raw_data_cat);
    %write this data to an excel format
    xlswrite([roi,'_Raw_Data.xls'],Raw_Data)

%Create 3-D Matrix [cond, time point, subject]
    %all_subs = [18 21 22 23 24 25 26 28 29 30 31 32];
    Mean = cat(3,Mean_sub18,Mean_sub21,Mean_sub22,Mean_sub23,Mean_sub24,Mean_sub25,Mean_sub26,Mean_sub28,Mean_sub29,Mean_sub30,Mean_sub31,Mean_sub32);
    %save this Matrix in .m format
    %save ([roi,'_Mean_3D'], 'Mean') 

%Fixed Effects Mean, std, sterr
    fcmean=mean(Mean,3);
    fcstd=std(Mean,0,3);
    fcsterr=fcstd/(sqrt(12));% n=12
    condensed_data = cat(1,fcmean,fcstd,fcsterr);
    sub_header_con = [11;12;22;99;11;12;22;99;11;12;22;99];
    condensed_data_cat = cat(2,sub_header_con,condensed_data);
    title_header_con = [1 -6 -4 -2 0 2 4 6 8 10 12 14 16];
    Condensed_Data = cat(1,title_header_con,condensed_data_cat);
    %write this to excel
    xlswrite([roi,'_Condensed_Data.xls'],Condensed_Data)
    
%Create 2D Matrix: Condition by time, across all subjects
    %Graph = mean(Mean,3);
    %save this Matrix in .m format
    %save ([roi,'Average_TimeSeries'],'Graph')
    %add title header
    %ttl_header = [-6 -4 -2 0 2 4 6 8 10 12 14 16];
    %Graph_A = cat(1,ttl_header,Graph);
    %write this data to an excel format (THIS ISN'T WORKING!!!)
    %xlswrite([roi,'_Average_TimeSeries.xls'],Graph_A)

    %Instead save as a text file
    %save ([roi,'Average_TimeSeries'], 'Graph_B', '-ascii', '-tabs') 

    
%Plot this Graph
%Plot = plot(Graph(1:12),'bs-','LineWidth',2);hold all;plot(Graph(2:12),'rs-','LineWidth',2);plot(Graph(3:12),'gs--','LineWidth',2);plot(Graph(4:12),'ks:','LineWidth',2);

%save this Plot: HOW!!!! (this saves the plot but it won't open
%save (['Average_TimeSeries_',roi,'.pdf'],'Plot')


