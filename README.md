# An fMRI preprocessing pipelien 

This is an automatic fMRI preprocessing pipeline based on the [SPM12](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/) and [CAT12](https://neuro-jena.github.io/cat/). It consists of the following steps: 

- Susceptibility distortion correction
- Realignment
- Segmentation of the structural data
- Normalization to the MNI space
- Smoothing 

I tried to make this pipeline as automatic as possible. You just need to set some directories and acquisition parameters, run the pipeline, and sit and drink your coffee!

## Useful info: 

- I used **CAT12** for the segmentation as it gives more precise results than the **SPM**.
- Make sure that before running the pipeline, you have downloaded the [Artifact Detection Tools (ART)](https://www.nitrc.org/projects/artifact_detect/) and have added its directory to the Matlab paths.
- Make sure that your data is organized in the BIDS format:
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
- To run the pipeline, open the `preprocessing.mat` file, set the requested directories and parameters, and run the file.
- If you need to change the hyperparmeters of different preprocessing steps, open the `func_PreprocBatch.mat` file, and set the parameters with your own values accordingly.

**Do not hesitate to send your feedback to improve this piepline!**
