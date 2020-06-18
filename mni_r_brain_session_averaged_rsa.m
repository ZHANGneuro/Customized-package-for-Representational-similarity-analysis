

root_path =  '/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/';

% info_pool = {
%     'w4s2_selfo', ...
%     'w4s2_map', ...
%     'w4s2_ego', ...
%     'w4s2_ed', ...
%     'w4s1_selfo', ...
%     'w4s1_map', ...
%     'w4s1_ego', ...
%     'w4s1_ed', ...
%     't4s_lc_t4s_selfo', ...
%     't4s_lc_t4s_map', ...
%     't4s_lc_t4s_ego', ...
%     't4s_lc_t4s_ed', ...
%     'f4s_lc_f4s_selfo', ...
%     'f4s_lc_f4s_map', ...
%     'f4s_lc_f4s_ego', ...
%     'f4s_lc_f4s_ed'};

info_pool = {
    'w8s_lc_w8s_ego', ...
    'w8s_lc_w8s_ed', ...
    'w8s_lc_w8s_map', ...
    'w8s_lc_w8s_selfo', ...
    };


for ith_info = 1:length(info_pool)
    
    folder_dir = dir(fullfile(root_path, ['*',info_pool{ith_info}, '*']));
    folder_dir = strcat(root_path,  {folder_dir.name}');
    
    
    foler_name2 = folder_dir{1};
    foler_name2 = strsplit(foler_name2, '_session');
    foler_name2 = foler_name2{1};
    
    sub_table = cell(26,4);
    
    for sub = 8:26
        
        brain_dir_s1 = dir(fullfile(folder_dir{1}, ['mni_sub',num2str(sub),'*']));
        brain_dir_s1 = strcat(folder_dir{1}, '/' ,{brain_dir_s1.name}');
        
        brain_dir_s2 = dir(fullfile(folder_dir{2}, ['mni_sub',num2str(sub),'*']));
        brain_dir_s2 = strcat(folder_dir{2}, '/' ,{brain_dir_s2.name}');
        
        brain_dir_s3 = dir(fullfile(folder_dir{3}, ['mni_sub',num2str(sub),'*']));
        brain_dir_s3 = strcat(folder_dir{3}, '/' ,{brain_dir_s3.name}');
        
        brain_dir_s4 = dir(fullfile(folder_dir{4}, ['mni_sub',num2str(sub),'*']));
        brain_dir_s4 = strcat(folder_dir{4}, '/' ,{brain_dir_s4.name}');
        
        s1_struct = MRIread(brain_dir_s1{1});
        s2_struct = MRIread(brain_dir_s2{1});
        s3_struct = MRIread(brain_dir_s3{1});
        s4_struct = MRIread(brain_dir_s4{1});
        s1_ima = s1_struct.vol;
        s2_ima = s2_struct.vol;
        s3_ima = s3_struct.vol;
        s4_ima = s4_struct.vol;
        
        ave_r_brain = (s1_ima + s2_ima + s3_ima +s4_ima) /4;
        temp_struc  = s1_struct;
        temp_struc.vol = ave_r_brain;
        output_path = [foler_name2, '_averaged'];
        if ~exist(output_path)
            mkdir(output_path)
        end
        MRIwrite(temp_struc,[output_path, '/mean_mni_sub', num2str(sub),'.nii']);
    end
end

