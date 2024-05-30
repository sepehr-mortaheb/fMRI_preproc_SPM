function func_PipelineSS(Dirs, subj, AcqParams)

out_dir = Dirs.out;
task_name = AcqParams.name;

%% Initialization
if ~isfolder(out_dir)
    mkdir(out_dir);
end

%% Reading the data
ffiles = func_ReadFiles(subj, task_name);
sfile = fullfile(subj.dir, 'anat', [subj.name '_T1w.nii']);

%% Preprocessing
func_Preproc(ffiles, sfile, Dirs, subj, AcqParams)
close all
