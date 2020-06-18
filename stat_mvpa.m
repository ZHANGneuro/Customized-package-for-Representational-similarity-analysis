


root_path =  '/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/';

folder_dir = dir(fullfile(root_path, 'fsl_glm_wft4_w8s_*_averaged*'));
folder_dir = strcat(root_path,  {folder_dir.name}');

for folder_ith = 1:length(folder_dir)
    
    % transform to 4d
    % curr_path = '/Users/boo/Desktop/fmri_script/analysis_MVPA/fsl_matrix_itself_diff_t4s_lc_tmap_ti_averaged/';
    curr_path = folder_dir{folder_ith};
    brain_dir = dir(fullfile(curr_path, 'mean*'));
    brain_dir = strcat(curr_path, '/' ,{brain_dir.name}');
    
    mni152_strct = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/brainmask/original_ima/MNI152_T1_2mm_template.nii');
    mni152_ima=mni152_strct.vol;
    ith_pool = find(mni152_ima~=0);
    for n = 1:length(brain_dir)
        empty_brain = mni152_ima;
        empty_brain(:,:,:)=0;
        sub_num = cell2mat(extractBetween(brain_dir{n}, 'sub', '.nii'));
        sub_brain = MRIread(brain_dir{n});
        sub_ima = sub_brain.vol;
        empty_brain(ith_pool) = sub_ima (ith_pool);
        sub_brain.vol = empty_brain;
        MRIwrite(sub_brain, [curr_path, '/mean_mni_sub', sub_num,'_fsl152.nii']);
    end
    
    % transform to 4d
    brain_dir = dir(fullfile(curr_path, '/*152.nii'));
    brain_dir = strcat(curr_path, '/',{brain_dir.name}');
    spm('defaults','fmri');
    spm_jobman('initcfg');
    matlabbatch =[];
    matlabbatch{1}.spm.util.cat.vols = brain_dir;
    matlabbatch{1}.spm.util.cat.name = '4d.nii';
    matlabbatch{1}.spm.util.cat.dtype = 4;
    spm_jobman('run',matlabbatch);
    
    % one sampel t
%     temp_strct = MRIread(brain_dir{1});

%     key_name = extractBetween(curr_path, 'fsl_matrix_', '_averaged');
%     key_name = key_name{1};
%     [~,voxel_uncorrp,~, STATS] = ttest(imgs_strct.vol, 0, 'Dim', 4,'tail', 'right');
%     voxel_uncorrp = 1- voxel_uncorrp;
%     voxel_uncorrp(find(isnan(voxel_uncorrp)))=0;
%     temp_strct.vol = voxel_uncorrp;
%     MRIwrite(temp_strct, ['/Users/boo/Desktop/', 'unc_' key_name  '.nii']);
    
%     sub_brain.vol = STATS.tstat;
%     MRIwrite(sub_brain, ['/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/uncorrected_noise/', 'tval_' key_name  '.nii']);

end







