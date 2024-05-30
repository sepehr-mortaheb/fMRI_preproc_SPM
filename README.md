# An fMRI preprocessing pipelien 

This is an automatic fMRI preprocessing pipeline based on the [SPM12](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/) and [CAT12](https://neuro-jena.github.io/cat/). It consists of the following steps: 

- Susceptibility distortion correction
- Realignment
- Segmentation of the structural data
- Normalization to the MNI space
- Smoothing 

I tried to make this pipeline as automatic as possible. You just need to set some directories and acquisition parameters, run the pipeline, and sit and drink your coffee! 
