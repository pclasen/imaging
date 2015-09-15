function [] = vector_concat(run)
% concatenate run level vectors across all subs
% run: string reflecting run number (e.g., 'R1')

% set dir/file
dir = ['~/Documents/NRSA/gimme/data/1d_Timecourses_csv/',run,'_out/betas/'];

% cycle through directory, concatenate individual vectors into group matrix
filelist = dir('*.mat');
group = [];
for i = 1:length(filelist);
    group = [group load(d(i).name)];
end

% save
save('full_group_contemp_reshaped.mat','x');




end