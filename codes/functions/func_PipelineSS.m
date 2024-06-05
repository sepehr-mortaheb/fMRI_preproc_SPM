function func_PipelineSS(Dirs, subj, AcqParams)

out_dir = Dirs.out;
task_name = AcqParams.name;
ses_list = subj.sessions;

%% Initialization
if ~isfolder(out_dir)
    mkdir(out_dir);
end

%% Preprocessing loop over the sessions 
for i = 1:numel(ses_list)
    ses = ses_list{i};
    % reading the data
    inpfiles = func_ReadFiles(subj, ses, task_name);
    
    % perform preprocessing
    func_Preproc(inpfiles, Dirs, subj, AcqParams)
    close all
end
