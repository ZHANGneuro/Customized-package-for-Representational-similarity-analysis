# Customized-package-for-Representational-similarity-analysis

This analysis was inititally developed by Kriegeskorte et al (2006) for the computation of multi-voxel pattern similarity of MRI BOLD image. 

###### *Kriegeskorte, N., Goebel, R., & Bandettini, P. (2006). Information-based functional brain mapping. Proceedings of the National Academy of Sciences, 103(10), 3863-3868.*


The scripts are the customized (simplified) version for representational similarity analysis, and was made for the paper published here: 

###### *Zhang, B., & Naya, Y. (2020). Medial prefrontal cortex represents the object-based cognitive map when remembering an egocentric target location. Cerebral Cortex, bhaa117, https://doi.org/10.1093/cercor/bhaa117*


## Docs:

1. preprocess MRI image e.g. using `FSL`. 
2. obtain multi-voxel pattern by creating a 1st level univarite GLM.
3. use `ct_by_voxel_fsl.m` to compute correlation matrix across trial-pairs for each image voxel.
4. use `mvpa_analysis_fsl_glm` to compute representational similarity by create a 2nd level GLM.

Note that recoding will be needed for your case.
