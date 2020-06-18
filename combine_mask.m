

%% combine aal

target_folder_path= '/Users/boo/Desktop/fmri_script/analysis_FC_mtl_hand/rois/';
brain_dir = dir(fullfile(target_folder_path, 'roi*'));
brain_dir = strcat(target_folder_path,   {brain_dir.name}');

label_table = cell(length(brain_dir),2);
for ith = 1:length(brain_dir)
    folder_name = brain_dir{ith};
    label_table{ith,2} = folder_name(end);
    folder_name(end-1:end)=[];
    label_table{ith,1} = folder_name;
end
unique_name = unique(label_table(:,1));



for ith= 1:length(unique_name)
    
    temp_label = unique_name{ith};
    left_folder = [temp_label, '_L'];
    right_folder = [temp_label, '_R'];
    
    temp_brain_left = dir(fullfile(left_folder, 'sub*'));
    temp_brain_left = strcat(left_folder,   '/',{temp_brain_left.name}');
    
    temp_brain_right = dir(fullfile(right_folder, 'sub*'));
    temp_brain_right = strcat(right_folder,   '/',{temp_brain_right.name}');
    
    for ith_file = 1:length(temp_brain_left)

        temp_file_path_left = temp_brain_left{ith_file};
        temp_file_path_right = temp_brain_right{ith_file};
        
        for_sub_sess_str = strsplit(temp_file_path_left, '/rois/');
        for_sub_sess_str = for_sub_sess_str{2};
        sub = extractBetween(for_sub_sess_str, 'sub', '_s');
        sub = sub{1};
        sess = extractBetween(for_sub_sess_str, '_s', '.nii');
        sess = sess{1};
        
        ima_strct_left = MRIread(temp_file_path_left);
        ima_left = ima_strct_left.vol;
        
        ima_strct_right = MRIread(temp_file_path_right);
        ima_right = ima_strct_right.vol;
        
        ima = ima_left + ima_right;
        ima_strct_left.vol = ima;
        
        if ~exist(temp_label)
            mkdir(temp_label);
        end
        
        MRIwrite(ima_strct_left, [temp_label, '/sub', sub, '_s', sess ,'.nii.gz']);

    end
end





%% combine hpc

path_left= '/Users/boo/Desktop/fmri_script/analysis_roi_mtl/mtl_hand_hardcut_l/';
brain_dir_L = dir(fullfile(path_left, 'co*'));
brain_dir_L = strcat(path_left,   {brain_dir_L.name}');

path_right= '/Users/boo/Desktop/fmri_script/analysis_roi_mtl/mtl_hand_hardcut_r/';
brain_dir_R = dir(fullfile(path_right, 'co*'));
brain_dir_R = strcat(path_right,   {brain_dir_R.name}');
    
    for ith_file = 1:length(brain_dir_R)

        temp_file_path_left = brain_dir_L{ith_file};
        temp_file_path_right = brain_dir_R{ith_file};
        
        info = extractBetween(temp_file_path_left, 'mtl_hand_hardcut_l/', '_l_sub');
        info = info{1};        
        sub = extractBetween(temp_file_path_left, 'sub', '_s');
        sub = sub{1};
        sess = extractBetween(temp_file_path_left, ['sub', sub,'_s'], '.nii');
        sess = sess{1};
        
        ima_strct_left = MRIread(temp_file_path_left);
        ima_left = ima_strct_left.vol;
        
        ima_strct_right = MRIread(temp_file_path_right);
        ima_right = ima_strct_right.vol;
        
        ima = ima_left + ima_right;
        ima_strct_left.vol = ima;
        
        MRIwrite(ima_strct_left, ['/Users/boo/Desktop/fmri_script/analysis_roi_mtl/mtl_hand_hardcut/' info '_sub', sub, '_s', sess ,'.nii.gz']);

    end

