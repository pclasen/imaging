function [] = vector_concat(run)
% concatenate run level vectors across all subs
% run: string reflecting run number (e.g., 'R1')

% set dir/file
DIR = ['~/Documents/NRSA/gimme/data/1d_Timecourses_csv/',run,'_out/betas/'];
cd(DIR)

% cycle through directory, concatenate individual vectors into group matrix
filelist = dir('*.mat');
group = [];
for i = 1:length(filelist);
    ind = load(filelist(i).name);
    vec = ind.vec;
    group = [group vec];
end

% save
filename1 = [DIR,run,'_full_group_contemp_reshaped.mat'];
save(filename1,'group');

filename2 = [DIR,run,'_full_group_contemp_reshaped.txt'];
fileX = cellstr(filename2);
dlmwrite(fileX{1},group,'delimiter','\t','precision','%.4f');




end