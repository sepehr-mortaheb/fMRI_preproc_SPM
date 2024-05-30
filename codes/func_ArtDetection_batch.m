function [matlabbatch, art_pth] = func_ArtDetection_batch(motionCorrectedDir, save_path, subj_name, TR)

matlabbatch = [];
dataMotion = spm_select('FPList', motionCorrectedDir, ['^swrau.*\.(img|nii)$']);
art_pth = fullfile(save_path, subj_name, 'func', 'artResults');
mkdir(art_pth);
matlabbatch{1}.spm.stats.fmri_spec.dir = {art_pth};
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = TR;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
matlabbatch{1}.spm.stats.fmri_spec.sess.scans = cellstr(dataMotion);
matlabbatch{1}.spm.stats.fmri_spec.sess.cond.name = 'cond1';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond.onset = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond.duration = inf;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond.tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond.pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

