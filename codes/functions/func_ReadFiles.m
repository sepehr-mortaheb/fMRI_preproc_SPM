function out = func_ReadFiles(subj, ses, task_name)

ffiles = dir(fullfile(subj.dir, ses, 'func'));
ffiles = ffiles(3:end);
sfiles = dir(fullfile(subj.dir, ses, 'anat'));
sfiles = sfiles(3:end);

fdata = ffiles(contains({files.name}, subj.name) & ...
               contains({files.name}, ses) & ...
               contains({files.name}, ['task-' task_name]) & ...
               contains({files.name}, 'bold.nii'));
           
sdata = sfiles(contains({files.name}, subj.name) & ...
               contains({files.name}, ses) & ...
               contains({files.name}, 'T1w.nii'));

fmap_files = dir(fullfile(subj.dir, ses, 'fmap'));
for i = 1:numel(fmap_files)
    if contains(fmap_files(i).name, 'magnitude1.nii')
        fmap_amp_file = fullfile(fmap_files(i).folder, fmap_files(i).name);
    elseif contains(fmap_files(i).name, 'phasediff.nii')
        fmap_pha_file = fullfile(fmap_files(i).folder, fmap_files(i).name);
    end
end

out = {fdata, fmap_amp_file, fmap_pha_file, sdata};