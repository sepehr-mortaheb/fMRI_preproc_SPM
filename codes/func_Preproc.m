function func_Preproc(ffiles, sfile, Dirs, subj, AcqParams)

save_path = Dirs.out; 
subj_name = subj.name;
TR = AcqParams.tr; 

%% Run Preprocessing Batch
spm fmri;
matlabbatch = func_PreprocBatch(ffiles, sfile, AcqParams, Dirs);
spm_jobman('run', matlabbatch)

%% Deleting unnecessary files and moving results to the related folder
 
% Functional data
motionCorrectedDir = fullfile(save_path, subj_name, ...
    'func', 'MotionCorrected');
mkdir(motionCorrectedDir);
datapath = fullfile(subj.dir, 'func');
delete(fullfile(datapath, 'ra*.*'));
delete(fullfile(datapath, 'meanra*.*'));
delete(fullfile(datapath, 'smeanrau*.*'));
delete(fullfile(datapath, '*.mat'));
delete(fullfile(datapath, 'u*.*'));
movefile(fullfile(datapath, 'swrau*.*'), motionCorrectedDir);
movefile(fullfile(datapath, 'rp_*.txt'), motionCorrectedDir);
movefile(fullfile(datapath, 'wrau*.*'), motionCorrectedDir);
 
% GRE-Field Data
peresDir = fullfile(save_path, subj_name, 'fmap');
mkdir(peresDir);
datapath = fullfile(subj.dir, 'fmap');
delete(fullfile(datapath, 'fpm*.*'));
delete(fullfile(datapath, 'sc*.*'));
movefile(fullfile(datapath, 'vdm*.*'), peresDir);
 
% Structural Data
stresDir = fullfile(save_path, subj_name, 'anat');
mkdir(stresDir);
datapath = fullfile(subj.dir, 'anat');
delete(fullfile(datapath, 'cat*.mat'));
delete(fullfile(datapath, 'cat*.jpg'));
delete(fullfile(datapath, 'cat*.txt'));
delete(fullfile(datapath, 'cat*.xml'));
delete(fullfile(datapath, 'msub*.*'));
movefile(fullfile(datapath, 'mwp1*.*'), stresDir);
movefile(fullfile(datapath, 'mwp2*.*'), stresDir);
movefile(fullfile(datapath, 'mwp3*.*'), stresDir);
movefile(fullfile(datapath, 'wmsub*.*'), stresDir);
movefile(fullfile(datapath, 'y_*.*'), stresDir);
movefile(fullfile(datapath, 'iy_*.*'), stresDir);
movefile(fullfile(datapath, 'cat*.pdf'), stresDir);
 
%% Run Artifact Detection Batch
  
clear matlabbatch;
[matlabbatch, art_pth] = func_ArtDetection_batch(motionCorrectedDir, save_path, subj_name, TR);
spm_jobman('serial', matlabbatch);
art_batch(fullfile(art_pth, 'SPM.mat'));