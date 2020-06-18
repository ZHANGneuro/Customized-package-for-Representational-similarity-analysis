

clear;
global_path ='/Users/boo/Documents/degree_PhD/data_fmri/';

for type_ith = 1
    if type_ith ==1
        sub_folder_name='f4s_lc_';
        keyw='f4s_lc_';
        nii_ima_fmap = cell(26,4);
        nii_ima_fed = cell(26,4);
        nii_ima_fdo = cell(26,4);
        nii_ima_fangle = cell(26,4);
        nii_ima_fdo_location = cell(26,4);
    elseif type_ith ==2
        sub_folder_name='t4s_lc_';
        keyw='t4s_lc_';
        nii_ima_tmap = cell(26,4);
        nii_ima_ted = cell(26,4);
        nii_ima_tdo = cell(26,4);
        nii_ima_fdo_location = cell(26,4);
        nii_ima_tdo_location = cell(26,4);
        nii_ima_tangle = cell(26,4);
        nii_ima_ego = cell(26,4);
    end
    
    r_matrix = cell(19,4);
    
    for sub = 8:26
        parfor session = 1:4
            
            ct_path = ['/fsl_big_matrix_', sub_folder_name, 's', num2str(session), '/'];
            output_table = create_volumn_table_each_session_fsl(global_path, sub, session, sub_folder_name);
            mask_brain = output_table{1,1}.vol;
            [d1, d2, d3] = ind2sub( size(mask_brain),find(mask_brain~=0));
            count_voxel = length(d1);
            if type_ith == 1
                temp_1d_fmap = nan(count_voxel,1);
                temp_1d_fed = nan(count_voxel,1);
                temp_1d_fdo = nan(count_voxel,1);
                temp_1d_fangle = nan(count_voxel,1);
                temp_1d_fdo_location = nan(count_voxel,1);
            elseif type_ith == 2
                temp_1d_tmap = nan(count_voxel,1);
                temp_1d_ted = nan(count_voxel,1);
                temp_1d_tdo = nan(count_voxel,1);
                temp_1d_tfdo_location = nan(count_voxel,1);
                temp_1d_tdo_location = nan(count_voxel,1);
                temp_1d_tangle = nan(count_voxel,1);
                temp_1d_ego = nan(count_voxel,1);
            end
            
            corr_3d_array = load([global_path, ct_path, 'sub' , num2str(sub), '_6mm_s', num2str(session),'.mat']);
            corr_3d_array = corr_3d_array.corr_3d_array;
            
            % temp for computing corr
            corr_2d_matrix = corr_3d_array(:,:,200);
            [b   RHO ]  = plot_hard_matrix_fsl(output_table, sub_folder_name, corr_2d_matrix);
            
            
            
            plot_hard_matrix_fsl(output_table, whether_plot, sub,session)
            
            
            
%             r_matrix{sub,session} = RHO;
            
%             parfor (each_voxel = 1:count_voxel)
%                 corr_2d_matrix = corr_3d_array(:,:,each_voxel);
%                 
%                 [b rho] = plot_hard_matrix_glm(output_table, sub_folder_name, corr_2d_matrix);
%                 
%                 if type_ith==1   %
%                     temp_1d_fmap(each_voxel,1) = b(2);
%                     temp_1d_fed(each_voxel,1) = b(3);
%                     temp_1d_fdo(each_voxel,1) = b(4);
%                     temp_1d_fangle(each_voxel,1) = b(5);
%                     temp_1d_fdo_location(each_voxel,1) = b(6);
%                 elseif type_ith==2
%                     temp_1d_tmap(each_voxel,1) = b(2);
%                     temp_1d_ted(each_voxel,1) = b(3);
%                     temp_1d_tdo(each_voxel,1) = b(4);
%                     temp_1d_fdo_location(each_voxel,1) = b(5);
%                     temp_1d_tdo_location(each_voxel,1) = b(6);
%                     temp_1d_tangle(each_voxel,1) = b(7);
%                     temp_1d_ego_left(each_voxel,1) = b(8);
%                     temp_1d_ego_right(each_voxel,1) = b(9);
%                     temp_1d_ego_back(each_voxel,1) = b(10);
%                 end
%                 disp([num2str(sub), '-', num2str(session) '-',num2str(each_voxel)]);
                disp([num2str(sub), '-', num2str(session)]);
%             end
%             if type_ith==1
%                 nii_ima_fmap{sub,session} = temp_1d_fmap;
%                 nii_ima_fed{sub,session} = temp_1d_fed;
%                 nii_ima_fdo{sub,session} = temp_1d_fdo;
%                 nii_ima_fangle{sub,session} = temp_1d_fangle;
%                 nii_ima_fdo_location{sub,session} = temp_1d_fdo_location;
%             elseif type_ith==2
%                 nii_ima_tmap{sub,session} = temp_1d_tmap;
%                 nii_ima_ted{sub,session} = temp_1d_ted;
%                 nii_ima_tdo{sub,session} = temp_1d_tdo;
%                 nii_ima_fdo_location{sub,session} = temp_1d_fdo_location;
%                 nii_ima_tdo_location{sub,session} = temp_1d_tdo_location;
%                 nii_ima_tangle{sub,session} = temp_1d_tangle;
%                 nii_ima_ego_left{sub,session} = temp_1d_ego_left;
%                 nii_ima_ego_right{sub,session} = temp_1d_ego_right;
%                 nii_ima_ego_back{sub,session} = temp_1d_ego_back;
%             end
        end
    end
%     
%     if type_ith==1
%         nii_imas_fmap= cell(26,4);
%         nii_imas_fed= cell(26,4);
%         nii_imas_fdo= cell(26,4);
%         nii_imas_fangle= cell(26,4);
%         nii_imas_fdo_location= cell(26,4);
%     elseif type_ith==2
%         nii_imas_tmap= cell(26,4);
%         nii_imas_ted= cell(26,4);
%         nii_imas_tdo= cell(26,4);
%         nii_imas_fdo_location= cell(26,4);
%         nii_imas_tdo_location= cell(26,4);
%         nii_imas_tangle= cell(26,4);
%         nii_imas_ego_left= cell(26,4);
%         nii_imas_ego_right= cell(26,4);
%         nii_imas_ego_back= cell(26,4);
%     end

%     for sub = 8:26
%         for session = 1:4
%             output_table =  create_volumn_table_each_session_fsl(global_path, sub, session, sub_folder_name);
%             mask_volume = output_table{1,1}.vol;
%             [d1, d2, d3] = ind2sub( size(mask_volume),find(mask_volume~=0));
%             count_voxel = length(d1);
%             if type_ith==1
%                 volume_fmap = zeros(size(mask_volume));
%                 volume_fed =zeros(size(mask_volume));
%                 volume_fdo = zeros(size(mask_volume));
%                 volume_fangle = zeros(size(mask_volume));
%                 volume_fdo_location = zeros(size(mask_volume));
%                 for voxel =  1:count_voxel
%                     volume_fmap(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_fmap{sub,session}(voxel);
%                     volume_fed(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_fed{sub,session}(voxel);
%                     volume_fdo(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_fdo{sub,session}(voxel);
%                     volume_fangle(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_fangle{sub,session}(voxel);
%                     volume_fdo_location(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_fdo_location{sub,session}(voxel);
%                 end
%             elseif type_ith==2
%                 volume_tmap = zeros(size(mask_volume));
%                 volume_ted =zeros(size(mask_volume));
%                 volume_tdo = zeros(size(mask_volume));
%                 volume_fdo_location = zeros(size(mask_volume));
%                 volume_tdo_location = zeros(size(mask_volume));
%                 volume_tangle = zeros(size(mask_volume));
%                 volume_ego_left = zeros(size(mask_volume));
%                 volume_ego_right = zeros(size(mask_volume));
%                 volume_ego_back = zeros(size(mask_volume));
%                 
%                 for voxel =  1:count_voxel
%                     volume_tmap(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_tmap{sub,session}(voxel);
%                     volume_ted(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_ted{sub,session}(voxel);
%                     volume_tdo(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_tdo{sub,session}(voxel);
%                     volume_fdo_location(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_fdo_location{sub,session}(voxel);
%                     volume_tdo_location(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_tdo_location{sub,session}(voxel);
%                     volume_tangle(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_tangle{sub,session}(voxel);
%                     volume_ego_left(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_ego_left{sub,session}(voxel);
%                     volume_ego_right(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_ego_right{sub,session}(voxel);
%                     volume_ego_back(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_ego_back{sub,session}(voxel);
%                     
%                 end
%             end
%             
%             if type_ith==1
%                 output_table{1,1}.vol = volume_fmap;
%                 output_table{2,1}.vol = volume_fed;
%                 output_table{3,1}.vol = volume_fdo;
%                 output_table{4,1}.vol = volume_fangle;
%                 output_table{5,1}.vol = volume_fdo_location;
%                 nii_imas_fmap{sub,session}= output_table{1,1};
%                 nii_imas_fed{sub,session}= output_table{2,1};
%                 nii_imas_fdo{sub,session}= output_table{3,1};
%                 nii_imas_fangle{sub,session}= output_table{4,1};
%                 nii_imas_fdo_location{sub,session}= output_table{5,1};
%             elseif type_ith==2
%                 output_table{1,1}.vol = volume_tmap;
%                 output_table{2,1}.vol = volume_ted;
%                 output_table{3,1}.vol = volume_tdo;
%                 output_table{4,1}.vol = volume_fdo_location;
%                 output_table{5,1}.vol = volume_tdo_location;
%                 output_table{6,1}.vol = volume_tangle;
%                 output_table{7,1}.vol = volume_ego_left;
%                 output_table{8,1}.vol = volume_ego_right;
%                 output_table{9,1}.vol = volume_ego_back;
%                 nii_imas_tmap{sub,session}= output_table{1,1};
%                 nii_imas_ted{sub,session}= output_table{2,1};
%                 nii_imas_tdo{sub,session}= output_table{3,1};
%                 nii_imas_fdo_location{sub,session}= output_table{4,1};
%                 nii_imas_tdo_location{sub,session}= output_table{5,1};
%                 nii_imas_tangle{sub,session}= output_table{6,1};
%                 nii_imas_ego_left{sub,session}= output_table{7,1};
%                 nii_imas_ego_right{sub,session}= output_table{8,1};
%                 nii_imas_ego_back{sub,session}= output_table{9,1};
%             end
%             disp([num2str(sub),'-',num2str(session)]);
%         end
%     end
%     
%     for sub= 8:26
%         for session =1:4
%             if type_ith==1
%                 mkdir([global_path,'/analysis_mvpa/fsl_glm_20181129_',  sub_folder_name ,'fmap_session', num2str(session)]);
%                 MRIwrite(nii_imas_fmap{sub,session},[global_path,'/analysis_mvpa/fsl_glm_20181129_',  sub_folder_name ,'fmap_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
%                 
%                 mkdir([global_path,'/analysis_mvpa/fsl_glm_20181129_',  sub_folder_name ,'fed_session', num2str(session)]);
%                 MRIwrite(nii_imas_fed{sub,session},[global_path,'/analysis_mvpa/fsl_glm_20181129_',  sub_folder_name ,'fed_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
%                 
%                 mkdir([global_path,'/analysis_mvpa/fsl_glm_20181129_',  sub_folder_name ,'fdo_session', num2str(session)]);
%                 MRIwrite(nii_imas_fdo{sub,session},[global_path,'/analysis_mvpa/fsl_glm_20181129_',  sub_folder_name ,'fdo_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
%                 
%                 mkdir([global_path,'/analysis_mvpa/fsl_glm_20181129_',  sub_folder_name ,'fangle_session', num2str(session)]);
%                 MRIwrite(nii_imas_fangle{sub,session},[global_path,'/analysis_mvpa/fsl_glm_20181129_',  sub_folder_name ,'fangle_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
%                 
%                 mkdir([global_path,'/analysis_mvpa/fsl_glm_20181129_',  sub_folder_name ,'fdo_location_session', num2str(session)]);
%                 MRIwrite(nii_imas_fdo_location{sub,session},[global_path,'/analysis_mvpa/fsl_glm_20181129_',  sub_folder_name ,'fdo_location_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);         
%             
%             
%             elseif type_ith==2
%                 mkdir([global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'tmap_session', num2str(session)]);
%                 MRIwrite(nii_imas_tmap{sub,session},[global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'tmap_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
%                 
%                 mkdir([global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'ted_session', num2str(session)]);
%                 MRIwrite(nii_imas_ted{sub,session},[global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'ted_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
%                 
%                 mkdir([global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'tdo_session', num2str(session)]);
%                 MRIwrite(nii_imas_tdo{sub,session},[global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'tdo_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
%                 
%                 mkdir([global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'fdo_location_session', num2str(session)]);
%                 MRIwrite(nii_imas_fdo_location{sub,session},[global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'fdo_location_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);    
%                 
%                 mkdir([global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'tdo_location_session', num2str(session)]);
%                 MRIwrite(nii_imas_tdo_location{sub,session},[global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'tdo_location_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);    
%                 
%                 mkdir([global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'tangle_session', num2str(session)]);
%                 MRIwrite(nii_imas_tangle{sub,session},[global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'tangle_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
%                 
%                 mkdir([global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'ego_left_session', num2str(session)]);
%                 MRIwrite(nii_imas_ego_left{sub,session},[global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'ego_left_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);   
%                 
%                 mkdir([global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'ego_right_session', num2str(session)]);
%                 MRIwrite(nii_imas_ego_right{sub,session},[global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'ego_right_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);   
%                 
%                 mkdir([global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'ego_back_session', num2str(session)]);
%                 MRIwrite(nii_imas_ego_back{sub,session},[global_path,'/analysis_mvpa/fsl_glm_ego_',  sub_folder_name ,'ego_back_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);   
%                 
%             end
%         end
%     end
end










