function [] = vector_gimmeContemp(sub,roi_num,run)
% create vector of subject's contemporaneous ROI relations from GIMME
% sub: string reflecting subject number input file from a master list (e.g., 's002_R1')
% roi_num: integer reflecting number of ROIs (e.g., 17)
% run: string reflecting run number (e.g., 'R1')

% vector size
vec_size = roi_num^2;

% set dir/file
dir = '~/Documents/NRSA/gimme/data/1d_Timecourses_csv/';
file = [dir,run,'_out/betas/',sub,'.csv'];

% readin data
dat = csvread(file,roi_num,roi_num);

% reshape & transpose
reshape_vec = reshape(dat,1,vec_size);
vec = reshape_vec';

% filename
filename = [dir,run,'_out/betas/',sub,'_contemp_vec.mat'];

% save
save(filename,'vec');



end

