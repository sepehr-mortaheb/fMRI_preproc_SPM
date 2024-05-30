function out = func_ReadFiles(subj, task_name)

fdata = fullfile(subj.dir, 'func', [subj.name '_task-' task_name '_bold.nii']);
fmap_files = dir(fullfile(subj.dir, 'fmap'));
for i = 1:numel(fmap_files)
    if contains(fmap_files(i).name, 'magnitude1.nii')
        fmap_amp_file = fullfile(fmap_files(i).folder, fmap_files(i).name);
    elseif contains(fmap_files(i).name, 'phasediff.nii')
        fmap_pha_file = fullfile(fmap_files(i).folder, fmap_files(i).name);
    end
end
out = {fdata, fmap_amp_file, fmap_pha_file};