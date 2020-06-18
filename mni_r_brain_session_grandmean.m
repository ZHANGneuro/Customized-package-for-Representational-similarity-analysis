

root_path = '/Users/boo/Desktop/fmri_script/analysis_FC_roi_searchlight/';

folder1= 'period_blank';
folder2= 'period_walking';
folder3= 'period_facing';
folder4= 'period_targeting';

root_path1 = [root_path,folder1, '/' ];
root_path2 = [root_path,folder2, '/' ];
root_path3 = [root_path,folder3, '/' ];
root_path4 = [root_path,folder4, '/' ];

each_cluster_dir1 = dir(fullfile(root_path1, 'r_map*'));
cluster_pool1 =  strcat(root_path1, {each_cluster_dir1.name}');
each_cluster_dir2 = dir(fullfile(root_path2, 'r_map*'));
cluster_pool2 =  strcat(root_path2, {each_cluster_dir2.name}');
each_cluster_dir3 = dir(fullfile(root_path3, 'r_map*'));
cluster_pool3 =  strcat(root_path3, {each_cluster_dir3.name}');
each_cluster_dir4 = dir(fullfile(root_path4, 'r_map*'));
cluster_pool4 =  strcat(root_path4, {each_cluster_dir4.name}');


for ith_cluster = 1:length(cluster_pool1)
    target_folder_path1 = cluster_pool1{ith_cluster};
    target_folder_path2 = cluster_pool2{ith_cluster};
    target_folder_path3 = cluster_pool3{ith_cluster};
    target_folder_path4 = cluster_pool4{ith_cluster};
    
    roi_folder_name = strsplit(target_folder_path1, [folder1, '/']);
    roi_folder_name = roi_folder_name{2};
    
    
    
    brain_dir1 = dir(fullfile(target_folder_path1, '/', 'mean_*'));
    brain_dir1 = strcat(target_folder_path1, '/',  {brain_dir1.name}');
    
    brain_dir2 = dir(fullfile(target_folder_path2, '/', 'mean_*'));
    brain_dir2 = strcat(target_folder_path2, '/',  {brain_dir2.name}');
    
    brain_dir3 = dir(fullfile(target_folder_path3, '/', 'mean_*'));
    brain_dir3 = strcat(target_folder_path3, '/',  {brain_dir3.name}');
    
    brain_dir4 = dir(fullfile(target_folder_path4, '/', 'mean_*'));
    brain_dir4 = strcat(target_folder_path4, '/',  {brain_dir4.name}');
    
    for ith_file = 1:length(brain_dir1)
        
        temp_s1 = MRIread(brain_dir1{ith_file});
        temp_s2 = MRIread(brain_dir2{ith_file});
        temp_s3 = MRIread(brain_dir3{ith_file});
        temp_s4 = MRIread(brain_dir4{ith_file});
        
        sub = extractBetween(brain_dir1{ith_file}, 'sub', '.nii');
        sub = sub{1};
        
        output_vol = (temp_s1.vol + temp_s2.vol + temp_s3.vol + temp_s4.vol)/4;
        temp_s1.vol = output_vol;
        
        output_path = [root_path, 'period_grandmean/', roi_folder_name];
        if ~exist(output_path, 'dir')
            mkdir(output_path);
        end
        MRIwrite(temp_s1,[output_path, '/mean_sub', num2str(sub),'.nii']);
    end
end


