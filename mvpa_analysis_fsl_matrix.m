

clear;
global_path ='/Users/boo/Documents/degree_PhD/data_fmri/';

sub_folder_name_f='f4s_lc_';


sub_folder_name_t='t4s_lc_';


r_matrix = cell(19,4);

for sub = 8:26
    for session = 1:4
        
        ct_path_f = ['/fsl_big_matrix_', sub_folder_name_f, 's', num2str(session), '/'];
        ct_path_t = ['/fsl_big_matrix_', sub_folder_name_t, 's', num2str(session), '/'];
        output_table_f = create_volumn_table_each_session_fsl(global_path, sub, session, sub_folder_name_f);
        output_table_t = create_volumn_table_each_session_fsl(global_path, sub, session, sub_folder_name_t);
        corre_index = plot_hard_matrix_fsl_7f(output_table_f);
        
        mask_brain_f = output_table_f{1,1}.vol;
        brain_index_f = find(mask_brain_f~=0);
        count_voxel_f = length(brain_index_f);
       
        mask_brain_t = output_table_t{1,1}.vol;
        brain_index_t = find(mask_brain_t~=0);
        count_voxel_t = length(brain_index_t);
        
        temp_1d_fmap = nan(count_voxel_f,1);
        temp_1d_fed = nan(count_voxel_f,1);
        temp_1d_ffdo = nan(count_voxel_f,1);
        temp_1d_ftdo = nan(count_voxel_f,1);
        temp_1d_ffdo_location = nan(count_voxel_f,1);
        temp_1d_ftdo_location = nan(count_voxel_f,1);
        temp_1d_fego = nan(count_voxel_f,1);
        temp_1d_tmap = nan(count_voxel_t,1);
        temp_1d_ted = nan(count_voxel_t,1);
        temp_1d_tfdo = nan(count_voxel_t,1);
        temp_1d_ttdo = nan(count_voxel_t,1);
        temp_1d_tfdo_location = nan(count_voxel_t,1);
        temp_1d_ttdo_location = nan(count_voxel_t,1);
        temp_1d_tego = nan(count_voxel_t,1);
        
        corr_3d_array_f = load([global_path, ct_path_f, 'sub' , num2str(sub), '_6mm_s', num2str(session),'.mat']);
        corr_3d_array_t = load([global_path, ct_path_t, 'sub' , num2str(sub), '_6mm_s', num2str(session),'.mat']);
        corr_3d_array_f = corr_3d_array_f.corr_3d_array;
        corr_3d_array_t = corr_3d_array_t.corr_3d_array;
        
        parfor (each_voxel = 1:count_voxel_f)
            corr_2d_matrix_f = corr_3d_array_f(:,:,each_voxel);
            temp_1d_fmap(each_voxel,1) = mean(corr_2d_matrix_f(corre_index{1})) - mean(corr_2d_matrix_f(corre_index{8}));
            temp_1d_fed(each_voxel,1) = mean(corr_2d_matrix_f(corre_index{2})) - mean(corr_2d_matrix_f(corre_index{8}));
            temp_1d_ffdo(each_voxel,1) = mean(corr_2d_matrix_f(corre_index{3})) - mean(corr_2d_matrix_f(corre_index{8}));
            temp_1d_ftdo(each_voxel,1) = mean(corr_2d_matrix_f(corre_index{4})) - mean(corr_2d_matrix_f(corre_index{8}));
            temp_1d_fego(each_voxel,1) = mean(corr_2d_matrix_f(corre_index{5})) - mean(corr_2d_matrix_f(corre_index{8}));
            temp_1d_ffdo_location(each_voxel,1) = mean(corr_2d_matrix_f(corre_index{6})) - mean(corr_2d_matrix_f(corre_index{8}));
            temp_1d_ftdo_location(each_voxel,1) = mean(corr_2d_matrix_f(corre_index{7})) - mean(corr_2d_matrix_f(corre_index{8}));
            disp([num2str(sub), '-', num2str(session) '-',num2str(each_voxel)]);
        end
        
        parfor (each_voxel = 1:count_voxel_t)
            corr_2d_matrix_t = corr_3d_array_t(:,:,each_voxel);
            temp_1d_tmap(each_voxel,1) = mean(corr_2d_matrix_t(corre_index{1})) - mean(corr_2d_matrix_t(corre_index{8}));
            temp_1d_ted(each_voxel,1) = mean(corr_2d_matrix_t(corre_index{2})) - mean(corr_2d_matrix_t(corre_index{8}));
            temp_1d_tfdo(each_voxel,1) = mean(corr_2d_matrix_t(corre_index{3})) - mean(corr_2d_matrix_t(corre_index{8}));
            temp_1d_ttdo(each_voxel,1) = mean(corr_2d_matrix_t(corre_index{4})) - mean(corr_2d_matrix_t(corre_index{8}));
            temp_1d_tego(each_voxel,1) = mean(corr_2d_matrix_t(corre_index{5})) - mean(corr_2d_matrix_t(corre_index{8}));
            temp_1d_tfdo_location(each_voxel,1) = mean(corr_2d_matrix_t(corre_index{6})) - mean(corr_2d_matrix_t(corre_index{8}));
            temp_1d_ttdo_location(each_voxel,1) = mean(corr_2d_matrix_t(corre_index{7})) - mean(corr_2d_matrix_t(corre_index{8}));
            disp([num2str(sub), '-', num2str(session) '-',num2str(each_voxel)]);
        end
        
        output_table_f{1,1}.vol(brain_index_f) = temp_1d_fmap;
        output_table_f{2,1}.vol(brain_index_f) = temp_1d_fed;
        output_table_f{3,1}.vol(brain_index_f) = temp_1d_ffdo;
        output_table_f{4,1}.vol(brain_index_f) = temp_1d_ftdo;
        output_table_f{5,1}.vol(brain_index_f) = temp_1d_ffdo_location;
        output_table_f{6,1}.vol(brain_index_f) = temp_1d_ftdo_location;
        output_table_f{7,1}.vol(brain_index_f) = temp_1d_fego;
        output_table_t{1,1}.vol(brain_index_t) = temp_1d_tmap;
        output_table_t{2,1}.vol(brain_index_t) = temp_1d_ted;
        output_table_t{3,1}.vol(brain_index_t) = temp_1d_tfdo;
        output_table_t{4,1}.vol(brain_index_t) = temp_1d_ttdo;
        output_table_t{5,1}.vol(brain_index_t) = temp_1d_tfdo_location;
        output_table_t{6,1}.vol(brain_index_t) = temp_1d_ttdo_location;
        output_table_t{7,1}.vol(brain_index_t) = temp_1d_tego;
        
        mkdir([global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_f ,'fmap_session', num2str(session)]);
        MRIwrite(output_table_f{1,1},[global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_f ,'fmap_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_f ,'fed_session', num2str(session)]);
        MRIwrite(output_table_f{2,1},[global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_f ,'fed_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_f ,'ffdo_session', num2str(session)]);
        MRIwrite(output_table_f{3,1},[global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_f ,'ffdo_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_f ,'ftdo_session', num2str(session)]);
        MRIwrite(output_table_f{4,1},[global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_f ,'ftdo_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_f ,'ffdo_location_session', num2str(session)]);
        MRIwrite(output_table_f{5,1},[global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_f ,'ffdo_location_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_f ,'ftdo_location_session', num2str(session)]);
        MRIwrite(output_table_f{6,1},[global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_f ,'ftdo_location_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_f ,'fego_session', num2str(session)]);
        MRIwrite(output_table_f{7,1},[global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_f ,'fego_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        
        mkdir([global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_t ,'tmap_session', num2str(session)]);
        MRIwrite(output_table_t{1,1},[global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_t ,'tmap_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_t ,'ted_session', num2str(session)]);
        MRIwrite(output_table_t{2,1},[global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_t ,'ted_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_t ,'tfdo_session', num2str(session)]);
        MRIwrite(output_table_t{3,1},[global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_t ,'tfdo_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_t ,'ttdo_session', num2str(session)]);
        MRIwrite(output_table_t{4,1},[global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_t ,'ttdo_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_t ,'tfdo_location_session', num2str(session)]);
        MRIwrite(output_table_t{5,1},[global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_t ,'tfdo_location_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_t ,'ttdo_location_session', num2str(session)]);
        MRIwrite(output_table_t{6,1},[global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_t ,'ttdo_location_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_t ,'tego_session', num2str(session)]);
        MRIwrite(output_table_t{7,1},[global_path,'analysis_mvpa/fsl_matrix_',  sub_folder_name_t ,'tego_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
    end
end

