

clear;
global_path ='/Users/boo/Documents/degree_PhD/data_fmri/';

for type_ith = 1
    if type_ith ==1
        sub_folder_name='w8s_lc_';
        keyw='w8s_lc_';
        nii_ima_w8s_map = cell(26,4);
        nii_ima_w8s_ed = cell(26,4);
        nii_ima_w8s_selfo = cell(26,4);
        nii_ima_w8s_ego = cell(26,4);
    end
    
    r_matrix = cell(19,4);
    
    for sub = 8:26
        for session = 1:4
            
            ct_path = ['/fsl_big_matrix_', sub_folder_name, 's', num2str(session), '/'];
            output_table = create_volumn_table_each_session_fsl(global_path, sub, session, sub_folder_name);
            mask_brain = output_table{1,1}.vol;
            [d1, d2, d3] = ind2sub( size(mask_brain),find(mask_brain~=0));
            count_voxel = length(d1);
            if type_ith == 1
                temp_1d_w8s_map = nan(count_voxel,1);
                temp_1d_w8s_ed = nan(count_voxel,1);
                temp_1d_w8s_selfo = nan(count_voxel,1);
                temp_1d_w8s_ego = nan(count_voxel,1);
            end
            
            corr_3d_array = load([global_path, ct_path, 'sub' , num2str(sub), '_6mm_s', num2str(session),'.mat']);
            corr_3d_array = corr_3d_array.corr_3d_array;
            
            parfor (each_voxel = 1:count_voxel)
                corr_2d_matrix = corr_3d_array(:,:,each_voxel);
                b = plot_hard_matrix_glm_wft_same_model(output_table, corr_2d_matrix)
                
                if type_ith==1   %
                    temp_1d_w8s_map(each_voxel,1) = b(2);
                    temp_1d_w8s_ed(each_voxel,1) = b(3);
                    temp_1d_w8s_selfo(each_voxel,1) = b(4);
                    temp_1d_w8s_ego(each_voxel,1) = b(5);
                end
                disp([num2str(sub), '-', num2str(session) '-',num2str(each_voxel)]);
            end
            
            if type_ith ==1
                nii_ima_w8s_map{sub,session} = temp_1d_w8s_map;
                nii_ima_w8s_ed{sub,session} = temp_1d_w8s_ed;
                nii_ima_w8s_selfo{sub,session} = temp_1d_w8s_selfo;
                nii_ima_w8s_ego{sub,session} = temp_1d_w8s_ego;
            end
        end
    end
    
    if type_ith ==1
        nii_imas_w8s_map= cell(26,4);
        nii_imas_w8s_ed= cell(26,4);
        nii_imas_w8s_selfo= cell(26,4);
        nii_imas_w8s_ego= cell(26,4);
    end
    
    for sub = 8:26
        for session = 1:4
            output_table =  create_volumn_table_each_session_fsl(global_path, sub, session, sub_folder_name);
            mask_volume = output_table{1,1}.vol;
            [d1, d2, d3] = ind2sub( size(mask_volume),find(mask_volume~=0));
            count_voxel = length(d1);
            if type_ith==1
                volume_w8s_map = zeros(size(mask_volume));
                volume_w8s_ed = zeros(size(mask_volume));
                volume_w8s_selfo = zeros(size(mask_volume));
                volume_w8s_ego = zeros(size(mask_volume));
                for voxel =  1:count_voxel
                    volume_w8s_map(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_w8s_map{sub,session}(voxel);
                    volume_w8s_ed(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_w8s_ed{sub,session}(voxel);
                    volume_w8s_selfo(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_w8s_selfo{sub,session}(voxel);
                    volume_w8s_ego(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_w8s_ego{sub,session}(voxel);
                end
            end
            
            if type_ith==1
                output_table{1,1}.vol = volume_w8s_map;
                output_table{2,1}.vol = volume_w8s_ed;
                output_table{3,1}.vol = volume_w8s_selfo;
                output_table{4,1}.vol = volume_w8s_ego;
                nii_imas_w8s_map{sub,session}= output_table{1,1};
                nii_imas_w8s_ed{sub,session}= output_table{2,1};
                nii_imas_w8s_selfo{sub,session}= output_table{3,1};
                nii_imas_w8s_ego{sub,session}= output_table{4,1};
            end
            
            disp([num2str(sub),'-',num2str(session)]);
        end
    end
    
    for sub= 8:26
        for session =1:4
            if type_ith==1
                mkdir([global_path,'/analysis_mvpa/fsl_glm_wft4_',  sub_folder_name ,'w8s_map_session', num2str(session)]);
                MRIwrite(nii_imas_w8s_map{sub,session},[global_path,'/analysis_mvpa/fsl_glm_wft4_',  sub_folder_name ,'w8s_map_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
                
                mkdir([global_path,'/analysis_mvpa/fsl_glm_wft4_',  sub_folder_name ,'w8s_ed_session', num2str(session)]);
                MRIwrite(nii_imas_w8s_ed{sub,session},[global_path,'/analysis_mvpa/fsl_glm_wft4_',  sub_folder_name ,'w8s_ed_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
                
                mkdir([global_path,'/analysis_mvpa/fsl_glm_wft4_',  sub_folder_name ,'w8s_selfo_session', num2str(session)]);
                MRIwrite(nii_imas_w8s_selfo{sub,session},[global_path,'/analysis_mvpa/fsl_glm_wft4_',  sub_folder_name ,'w8s_selfo_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
                
                mkdir([global_path,'/analysis_mvpa/fsl_glm_wft4_',  sub_folder_name ,'w8s_ego_session', num2str(session)]);
                MRIwrite(nii_imas_w8s_ego{sub,session},[global_path,'/analysis_mvpa/fsl_glm_wft4_',  sub_folder_name ,'w8s_ego_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
            end
        end
    end
end










