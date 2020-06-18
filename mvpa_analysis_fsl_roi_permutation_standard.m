




global_path ='/Users/boo/Documents/degree_PhD/data_fmri/';


tmap_dorsal_struct = MRIread('/Users/boo/Desktop/rsa_tmap_dorsal_cluster.nii');
tmap_dorsal_mask = tmap_dorsal_struct.vol;
tmap_dorsal_index = find(tmap_dorsal_mask==1);

tmap_rectus_struct = MRIread('/Users/boo/Desktop/rsa_tmap_rectus.nii');
tmap_rectus_mask = tmap_rectus_struct.vol;
tmap_rectus_index = find(tmap_rectus_mask==1);

fmap_hpc_struct = MRIread('/Users/boo/Desktop/rsa_fmap_mhpc.nii');
fmap_hpc_mask = fmap_hpc_struct.vol;
fmap_hpc_index = find(fmap_hpc_mask==1);




tmap_path= '/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/fsl_glm_20181129_chaslocationt4s_lc_tmap_averaged_no2ndnor/';
tmap_beta_dir = dir(fullfile(tmap_path, '*fsl152*'));
tmap_beta_dir = strcat(tmap_path ,{tmap_beta_dir.name}');

fmap_path= '/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/fsl_glm_20181129_f4s_fmap_averaged_no2ndnor/';
fmap_beta_dir = dir(fullfile(fmap_path, '*fsl152*'));
fmap_beta_dir = strcat(fmap_path ,{fmap_beta_dir.name}');

tmap_dorsal_f = [];
tmap_dorsal_t = [];
tmap_rectus_f = [];
tmap_rectus_t = [];
fmap_mhpc_f = [];
fmap_mhpc_t = [];
for ith = 1:length(tmap_beta_dir)
    
    curr_tmap_beta_path = tmap_beta_dir{ith};
    curr_fmap_beta_path = fmap_beta_dir{ith};
    
    curr_tmap_beta_stru = MRIread(curr_tmap_beta_path);
    curr_fmap_beta_stru = MRIread(curr_fmap_beta_path);

    curr_tmap_beta_ima = curr_tmap_beta_stru.vol;
    curr_fmap_beta_ima = curr_fmap_beta_stru.vol;
    
    fmap_mhpc_f = [fmap_mhpc_f, mean(curr_fmap_beta_ima(fmap_hpc_index))];
    fmap_mhpc_t = [fmap_mhpc_t, mean(curr_tmap_beta_ima(fmap_hpc_index))];
    
    tmap_rectus_f = [tmap_rectus_f, mean(curr_fmap_beta_ima(tmap_rectus_index))];
    tmap_rectus_t = [tmap_rectus_t, mean(curr_tmap_beta_ima(tmap_rectus_index))];

    tmap_dorsal_f = [tmap_dorsal_f, mean(curr_fmap_beta_ima(tmap_dorsal_index))];
    tmap_dorsal_t = [tmap_dorsal_t, mean(curr_tmap_beta_ima(tmap_dorsal_index))];
end


[H,P,CI,STATS] = ttest(fmap_mhpc_f,fmap_mhpc_t)
[H,P,CI,STATS] = ttest(tmap_rectus_f,tmap_rectus_t)
[H,P,CI,STATS] = ttest(tmap_dorsal_f,tmap_dorsal_t)

