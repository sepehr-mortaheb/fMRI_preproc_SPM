clc 
clear 

%% Initialization 

% --- Set the following directories --- 

% Directory of the BIDS formated data:
bids_dir = '';
% Save directory of the fMRI processing:
save_dir = '';

%##########################################################################
% --- Pipeline Steps ---

% Slice Timing Correction? 0:No, 1:Yes
STC = 1; 
% Susceptibility Distortion Correction? 0:No, 1:VDM(SPM), 2:TopUp(FSL)
SDC = 0; 

%##########################################################################
% --- Set the Acquisition Parameters --- 

% ------ General Parmaeters ------
% The name of the functional task
task_name = 'rest';
% Repetition Time (RT) of the functional acquisition (seconds)
func_TR = 2; 

% ------ SDC-Specific Parameters ------
% Echo time of (TE) of the functional data (ms)
echo_time = [4.92 7.38];
% Total EPI read-out time (ms)
total_EPI_rot = 46.48;

% ------ STC-Specific Parameters ------ 
% Number of Slices
stc_num = 42;
% Slice Order (1=ascending, 2=descending, 3=interleaved(middle-top),
% 4=interleaved(buttom-up), 5=interleaved(top-down), 6:slice timings
% available in the JSON file)
stc_ord = 6;
% Reference Slice
stc_ref = 1;

%##########################################################################
% --- Set the Participants Information --- 

% Subjects list [Ex: {'sub-XXX'; 'sub-YYY'}]
subj_list = {'sub-Test'};

% Sessions list [Ex: {'ses-ZZZ'; 'ses-TTT'}]
ses_list = {'ses-1'};

%##########################################################################
% --- Creating Handy Variables and AddPath Required Directories ---

% Directories Struct
art_dir = which('art');
art_dir(end-4:end) = []; 
spm_dir = which('spm');
spm_dir(end-4:end) = [];
Dirs = struct();
Dirs.bids = bids_dir; 
Dirs.out = save_dir;
Dirs.spm = spm_dir;
Dirs.art = art_dir;

% Acquisition Parameters Struct
AcqParams = struct();
AcqParams.name = task_name;
AcqParams.tr = func_TR; 
AcqParams.et = echo_time;
AcqParams.trot = total_EPI_rot;
AcqParams.nslc = stc_num;
AcqParams.ordslc = stc_ord;
AcqParams.refslc = stc_ref;

% Subject Information Struct
Subjects(length(subj_list)) = struct();
for i=1:length(subj_list)
    Subjects(i).name = subj_list{i};
    Subjects(i).dir = fullfile(bids_dir, subj_list{i});
    Subjects(i).sessions = ses_list; 
end

% Adding required paths 
addpath(art_dir);
addpath(spm_dir);
addpath(fullfile(spm_dir, 'src'));
addpath('./functions');

%% Functional Pipeline 

% Which pipeline:
pipeline = 10^SDC + STC; 
% 1: SDC=0, STC=0
% 2: SDC=0, STC=1
% 10: SDC=1, STC=0
% 11: SDC=1, STC=1
% 100: SDC=2, STC=0
% 101: SDC=2, STC=1

for subj_num = 1:numel(subj_list)
    subj = subj_list{subj_num};
    func_PipelineSS(Dirs, Subjects(subj_num), AcqParams, pipeline);
end