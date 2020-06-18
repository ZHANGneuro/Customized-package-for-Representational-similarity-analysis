

root_path =  '/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_period/';

info_pool = {'hnd_raw_baseline*', 'hnd_raw_walking*', 'hnd_raw_facing*', 'hnd_raw_targeting*', 'hnd_raw_hnd*'};

for ith_info = 1:length(info_pool)
    
    folder_dir = dir(fullfile(root_path, info_pool{ith_info}));
    folder_dir = strcat(root_path,  {folder_dir.name}');
    
    for folder_ith = 1:length(folder_dir)
        
        period_key = folder_dir{folder_ith};
        period_key = strsplit(period_key, 'analysis_contrast_period/');
        period_key = period_key{2};
                
        sub_table = cell(26,4);
        
        for sub = 8:26
            
            target_folder_path = [root_path, period_key,'/'];
            brain_dir = dir(fullfile(target_folder_path, ['mni_sub',num2str(sub),'*']));
            brain_dir = strcat(target_folder_path,  {brain_dir.name}');
            
            s1_struct = MRIread(brain_dir{1});
            s2_struct = MRIread(brain_dir{2});
            s3_struct = MRIread(brain_dir{3});
            s4_struct = MRIread(brain_dir{4});
            s1_ima = s1_struct.vol;
            s2_ima = s2_struct.vol;
            s3_ima = s3_struct.vol;
            s4_ima = s4_struct.vol;

            ave_r_brain = (s1_ima + s2_ima + s3_ima +s4_ima) /4;
            temp_struc  = s1_struct;
            temp_struc.vol = ave_r_brain;
            output_path = [root_path,period_key, '_averaged'];
            MRIwrite(temp_struc,[root_path, period_key, '/mni_sub', num2str(sub),'_averaged.nii']);
        end
    end
end

