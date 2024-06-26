# An fMRI preprocessing pipeline 

This is an automatic fMRI spatial preprocessing pipeline based on the [SPM12](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/) and [CAT12](https://neuro-jena.github.io/cat/) that can be used for both task-based and resting-state fMRI data. It consists of the following steps: 

- Susceptibility distortion correction
  - VDM calculation based on the fieldmap phase and amplitude data. 
- Realignment and Unwarp
  - Simultaneous realignment of functional volumes and applying VDM.
- Segmentation of the structural data
  - It also creates a bias-corrected T1 image, normalizes it and all the extracted tissue masks to the MNI space, and outputs the forward and inverse transformation parameters.
- Coregistration of the functional data into the T1 image.
  - It aligns the functional data to the bias-corrected T1 image.
- Normalization to the MNI space
  - It uses the forward transformation parameters of the segmentation step, to normalize the functional data into the MNI space. 
- Smoothing 

I tried to make this pipeline as automatic as possible. You just need to set some directories and acquisition parameters, run the pipeline, and sit and drink your coffee!

## Useful info: 

- I used **CAT12** for the segmentation as it gives more precise results than the **SPM**.
- Make sure that before running the pipeline, you have downloaded the [Artifact Detection Tools (ART)](https://www.nitrc.org/projects/artifact_detect/) and have added its directory to the Matlab paths. Also make sure that you have downloaded the [CAT12](https://neuro-jena.github.io/cat/) package and have put it in the **SPM toolbox** folder. 
- The pipeline considers that your data is organized in the BIDS format as follows:
  ```
  Data_dir -->
              sub-XXX
              sub-YYY
              .
              .
              .
              sub-ZZZ -->
                         ses-xxx
                         ses-yyy
                         .
                         .
                         .
                         ses-zzz -->
                                    anat -->
                                            sub-ZZZ_ses-zzz_T1w.json
                                            sub-ZZZ_ses-zzz_T1w.nii
                                    fmap -->
                                            sub-ZZZ_ses-zzz_task-<TaskName>_magnitude1.json
                                            sub-ZZZ_ses-zzz_task-<TaskName>_magnitude1.nii
                                            sub-ZZZ_ses-zzz_task-<TaskName>_phasediff.json
                                            sub-ZZZ_ses-zzz_task-<TaskName>_phasediff.nii
                                    func -->
                                            sub-ZZZ_ses-zzz_task-<TaskName>_bold.json
                                            sub-ZZZ_ses-zzz_task-<TaskName>_bold.nii
  ```
- To run the pipeline, open the `preprocessing.m` file, set the requested directories and parameters, and run the file.
- If you need to change the hyperparmeters of different preprocessing steps, open the `func_PreprocBatch.m` file, and set the parameters with your own values accordingly.
- I have tested the pipeline on `macOS Sonoma Version 14.5` and it works without any error.

**Do not hesitate to send your feedback to improve this pipeline!**
