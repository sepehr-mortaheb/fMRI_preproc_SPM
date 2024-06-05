function out = func_ReadFiles(subj, ses, task_name)

fdata = fullfile(subj.dir, ses, 'func', [subj.name '_' ses '_task-' task_name '_bold.nii']);
sdata = fullfile(subj.dir, ses, 'anat', [subj.name '_' ses '_T1w.nii']);

fmap_files = dir(fullfile(subj.dir, ses, 'fmap'));
for i = 1:numel(fmap_files)
    if contains(fmap_files(i).name, 'magnitude1.nii')
        fmap_amp_file = fullfile(fmap_files(i).folder, fmap_files(i).name);
    elseif contains(fmap_files(i).name, 'phasediff.nii')
        fmap_pha_file = fullfile(fmap_files(i).folder, fmap_files(i).name);
    end
end

out = {fdata, fmap_amp_file, fmap_pha_file, sdata};