function matlabbatch = func_PreprocBatch(ffiles, sfile, AcqParams, Dirs)

echo_time = AcqParams.et;
total_EPI_rot = AcqParams.trot;

spm_dir = Dirs.spm;
fdata = ffiles{1};
sdata = sfile;
ampdata = ffiles{2};
phasedata = ffiles{3};

%% Reading the structural, functional, and fmap data 
matlabbatch{1}.cfg_basicio.file_dir.file_ops.cfg_named_file.name = 'struct';
matlabbatch{1}.cfg_basicio.file_dir.file_ops.cfg_named_file.files = {cellstr(sdata)}';
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_named_file.name = 'func';
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_named_file.files = {cellstr(fdata)};
matlabbatch{3}.cfg_basicio.file_dir.file_ops.cfg_named_file.name = 'gf_phase';
matlabbatch{3}.cfg_basicio.file_dir.file_ops.cfg_named_file.files = {cellstr(phasedata)};
matlabbatch{4}.cfg_basicio.file_dir.file_ops.cfg_named_file.name = 'gf_amp';
matlabbatch{4}.cfg_basicio.file_dir.file_ops.cfg_named_file.files = {cellstr(ampdata)};

%% Calculate VDM for Susceptibility Distortion Correction 
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.data.presubphasemag.phase(1) = cfg_dep('Named File Selector: gf_phase(1) - Files', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.data.presubphasemag.magnitude(1) = cfg_dep('Named File Selector: gf_amp(1) - Files', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.et = echo_time;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.maskbrain = 0;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.blipdir = -1;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.tert = total_EPI_rot;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.epifm = 1;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.ajm = 0;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.method = 'Mark3D';
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.fwhm = 10;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.pad = 0;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.ws = 1;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.template = {fullfile(spm_dir, 'toolbox', 'FieldMap', 'T1.nii')};
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.fwhm = 5;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.nerode = 2;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.ndilate = 4;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.thresh = 0.5;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.reg = 0.02;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.session.epi(1) = cfg_dep('Named File Selector: func(1) - Files', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.matchvdm = 1;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.sessname = 'session';
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.writeunwarped = 0;
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.anat = '';
matlabbatch{5}.spm.tools.fieldmap.calculatevdm.subj.matchanat = 0;

%% Realign Unwarp for realignment and susceptibility distortion correction 
matlabbatch{6}.spm.spatial.realignunwarp.data.scans(1) = cfg_dep('Named File Selector: func(1) - Files', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{6}.spm.spatial.realignunwarp.data.pmscan(1) = cfg_dep('Calculate VDM: Voxel displacement map (Subj 1, Session 1)', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','vdmfile', '{}',{1}));
matlabbatch{6}.spm.spatial.realignunwarp.eoptions.quality = 0.9;
matlabbatch{6}.spm.spatial.realignunwarp.eoptions.sep = 4;
matlabbatch{6}.spm.spatial.realignunwarp.eoptions.fwhm = 5;
matlabbatch{6}.spm.spatial.realignunwarp.eoptions.rtm = 0;
matlabbatch{6}.spm.spatial.realignunwarp.eoptions.einterp = 2;
matlabbatch{6}.spm.spatial.realignunwarp.eoptions.ewrap = [0 0 0];
matlabbatch{6}.spm.spatial.realignunwarp.eoptions.weight = '';
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.basfcn = [12 12];
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.regorder = 1;
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.lambda = 100000;
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.jm = 0;
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.fot = [4 5];
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.sot = [];
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.uwfwhm = 4;
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.rem = 1;
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.noi = 5;
matlabbatch{6}.spm.spatial.realignunwarp.uweoptions.expround = 'Average';
matlabbatch{6}.spm.spatial.realignunwarp.uwroptions.uwwhich = [2 1];
matlabbatch{6}.spm.spatial.realignunwarp.uwroptions.rinterp = 4;
matlabbatch{6}.spm.spatial.realignunwarp.uwroptions.wrap = [0 0 0];
matlabbatch{6}.spm.spatial.realignunwarp.uwroptions.mask = 1;
matlabbatch{6}.spm.spatial.realignunwarp.uwroptions.prefix = 'rau';

%% Segmentation and Normalization using CAT12
matlabbatch{7}.spm.tools.cat.estwrite.data(1) = cfg_dep('Named File Selector: struct(1) - Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{7}.spm.tools.cat.estwrite.data_wmh = {''};
matlabbatch{7}.spm.tools.cat.estwrite.nproc = 4;
matlabbatch{7}.spm.tools.cat.estwrite.useprior = '';
matlabbatch{7}.spm.tools.cat.estwrite.opts.tpm = {fullfile(spm_dir, 'tpm', 'TPM.nii')};
matlabbatch{7}.spm.tools.cat.estwrite.opts.affreg = 'mni';
matlabbatch{7}.spm.tools.cat.estwrite.opts.biasacc = 0.5;
matlabbatch{7}.spm.tools.cat.estwrite.extopts.restypes.optimal = [1 0.3];
matlabbatch{7}.spm.tools.cat.estwrite.extopts.setCOM = 1;
matlabbatch{7}.spm.tools.cat.estwrite.extopts.APP = 1070;
matlabbatch{7}.spm.tools.cat.estwrite.extopts.affmod = 0;
matlabbatch{7}.spm.tools.cat.estwrite.extopts.spm_kamap = 0;
matlabbatch{7}.spm.tools.cat.estwrite.extopts.LASstr = 0.5;
matlabbatch{7}.spm.tools.cat.estwrite.extopts.LASmyostr = 0;
matlabbatch{7}.spm.tools.cat.estwrite.extopts.gcutstr = 2;
matlabbatch{7}.spm.tools.cat.estwrite.extopts.WMHC = 2;
matlabbatch{7}.spm.tools.cat.estwrite.extopts.registration.shooting.shootingtpm = {fullfile(spm_dir, 'toolbox', 'cat12', 'templates_MNI152NLin2009cAsym', 'Template_0_GS.nii')};
matlabbatch{7}.spm.tools.cat.estwrite.extopts.registration.shooting.regstr = 0.5;
matlabbatch{7}.spm.tools.cat.estwrite.extopts.vox = 1.5;
matlabbatch{7}.spm.tools.cat.estwrite.extopts.bb = 12;
matlabbatch{7}.spm.tools.cat.estwrite.extopts.SRP = 22;
matlabbatch{7}.spm.tools.cat.estwrite.extopts.ignoreErrors = 1;
matlabbatch{7}.spm.tools.cat.estwrite.output.BIDS.BIDSno = 1;
matlabbatch{7}.spm.tools.cat.estwrite.output.surface = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.surf_measures = 1;
matlabbatch{7}.spm.tools.cat.estwrite.output.ROImenu.noROI = struct([]);
matlabbatch{7}.spm.tools.cat.estwrite.output.GM.native = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.GM.mod = 1;
matlabbatch{7}.spm.tools.cat.estwrite.output.GM.dartel = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.WM.native = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.WM.mod = 1;
matlabbatch{7}.spm.tools.cat.estwrite.output.WM.dartel = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.CSF.native = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.CSF.warped = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.CSF.mod = 1;
matlabbatch{7}.spm.tools.cat.estwrite.output.CSF.dartel = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.ct.native = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.ct.warped = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.ct.dartel = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.pp.native = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.pp.warped = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.pp.dartel = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.WMH.native = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.WMH.warped = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.WMH.mod = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.WMH.dartel = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.SL.native = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.SL.warped = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.SL.mod = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.SL.dartel = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.TPMC.native = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.TPMC.warped = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.TPMC.mod = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.TPMC.dartel = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.atlas.native = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.label.native = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.label.warped = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.label.dartel = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.labelnative = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.bias.warped = 1;
matlabbatch{7}.spm.tools.cat.estwrite.output.las.native = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.las.warped = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.las.dartel = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.jacobianwarped = 0;
matlabbatch{7}.spm.tools.cat.estwrite.output.warps = [1 1];
matlabbatch{7}.spm.tools.cat.estwrite.output.rmat = 0;

%% Normalization of Functional Data to the MNI Space 
matlabbatch{8}.spm.spatial.normalise.write.subj.def(1) = cfg_dep('CAT12: Segmentation: Deformation Field', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','fordef', '()',{':'}));
matlabbatch{8}.spm.spatial.normalise.write.subj.resample(1) = cfg_dep('Realign & Unwarp: Unwarped Images (Sess 1)', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{1}, '.','uwrfiles'));
matlabbatch{8}.spm.spatial.normalise.write.woptions.bb = [-Inf -Inf -Inf
                                                          Inf Inf Inf];
matlabbatch{8}.spm.spatial.normalise.write.woptions.vox = [2 2 2];
matlabbatch{8}.spm.spatial.normalise.write.woptions.interp = 4;
matlabbatch{8}.spm.spatial.normalise.write.woptions.prefix = 'w';

%% Smoothing
matlabbatch{9}.spm.spatial.smooth.data(1) = cfg_dep('Normalise: Write: Normalised Images (Subj 1)', substruct('.','val', '{}',{8}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{9}.spm.spatial.smooth.fwhm = [4 4 4];
matlabbatch{9}.spm.spatial.smooth.dtype = 0;
matlabbatch{9}.spm.spatial.smooth.im = 0;
matlabbatch{9}.spm.spatial.smooth.prefix = 's';
