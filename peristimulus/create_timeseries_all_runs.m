function create_conditionts_image_all
%batch_Psplot : compute peri-stimulus timecourse for FEAT fMRI data
%change values in batch_psplot.m to match your setup

params.NegWindow = 6; %from 6 seconds prior to onset
params.PosWindow = 18; %until 18 seconds after stimulus onset
params.ter = 2.0

% Subjects numbered 15-32 have 4 runs. 

for a = [15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]

%first: assign parameters used by selective_avg
params.sed_converter = '/mnt/home/pclasen/matlab/fslroi/designconvert.sed';
params.sed_converter2 = '/mnt/home/pclasen/matlab/fslroi/designconvert2.sed';
params.ClusterInStandardSpace = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run1.feat/example_func2standard.nii.gz'];
%        - note: optional: set to '' to turn off. Provides reference image
%        for applyxfm4D (so coregistered output will have correct bounding box).
%
%run selective_avg with parameters: output: one 4D image per condition
%each slice of 4D image repesents different averaged time-point~schnyer/matlab/selective_avg.m
%output saved in folder 'ROI' within the .FEAT' directory

%run for run1

params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run1.feat'];

selective_avg2b(params);

% now for run2

params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run2.feat'];

selective_avg2b(params);

% now for run3

params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run3.feat'];

selective_avg2b(params);

% now for run4

params.featdir = ['/mnt/psychresearch/pclasen/eref/eref_analysis/eref_subject' int2str(a) '/analysis/run4.feat'];

selective_avg2b(params);
end