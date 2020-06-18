

clear;
global_path ='/Users/boo/Documents/degree_PhD/data_fmri/';

sub_folder_name='ft8s_';
keyw='ft8s_';
nii_ima_fmap = cell(26,4);
nii_ima_fed = cell(26,4);
nii_ima_ffdo = cell(26,4);
nii_ima_ftdo = cell(26,4);
nii_ima_ffdo_location = cell(26,4);
nii_ima_ftdo_location = cell(26,4);
nii_ima_fego = cell(26,4);
nii_ima_fangle = cell(26,4);

r_matrix = cell(19,4);

for sub = 8:26
    for session = 1:4
        
        ct_path = ['/fsl_big_matrix_', sub_folder_name, 's', num2str(session), '/'];
        output_table = create_volumn_table_each_session_fsl(global_path, sub, session, sub_folder_name);
        mask_brain = output_table{1,1}.vol;
        [d1, d2, d3] = ind2sub( size(mask_brain),find(mask_brain~=0));
        count_voxel = length(d1);
        
        temp_1d_fmap = nan(count_voxel,1);
        temp_1d_fed = nan(count_voxel,1);
        temp_1d_ffdo = nan(count_voxel,1);
        temp_1d_ftdo = nan(count_voxel,1);
        temp_1d_ffdo_location = nan(count_voxel,1);
        temp_1d_ftdo_location = nan(count_voxel,1);
        temp_1d_fego = nan(count_voxel,1);
        temp_1d_fangle = nan(count_voxel,1);
        
        
        
        corr_3d_array = load([global_path, ct_path, 'sub' , num2str(sub), '_6mm_s', num2str(session),'.mat']);
        corr_3d_array = corr_3d_array.corr_3d_array;
        
        % temp for computing corr
        %             corr_2d_matrix = corr_3d_array(:,:,200);
        %             [b   RHO ]  = plot_hard_matrix_fsl(output_table, sub_folder_name, corr_2d_matrix);
        %             plot_hard_matrix_fsl(output_table, whether_plot, sub,session)
        %             r_matrix{sub,session} = RHO;
        
        parfor (each_voxel = 1:count_voxel)
            corr_2d_matrix = corr_3d_array(:,:,each_voxel);
            
            [b rho] = plot_hard_matrix_glm_8s(output_table, sub_folder_name, corr_2d_matrix);
            
            temp_1d_fmap(each_voxel,1) = b(2);
            temp_1d_fed(each_voxel,1) = b(3);
            temp_1d_ffdo(each_voxel,1) = b(4);
            temp_1d_ftdo(each_voxel,1) = b(5);
            temp_1d_ffdo_location(each_voxel,1) = b(6);
            temp_1d_ftdo_location(each_voxel,1) = b(7);
            temp_1d_fego(each_voxel,1) = b(8);
            temp_1d_fangle(each_voxel,1) = b(9);
            disp([num2str(sub), '-', num2str(session) '-',num2str(each_voxel)]);
        end
        nii_ima_fmap{sub,session} = temp_1d_fmap;
        nii_ima_fed{sub,session} = temp_1d_fed;
        nii_ima_ffdo{sub,session} = temp_1d_ffdo;
        nii_ima_ftdo{sub,session} = temp_1d_ftdo;
        nii_ima_ffdo_location{sub,session} = temp_1d_ffdo_location;
        nii_ima_ftdo_location{sub,session} = temp_1d_ftdo_location;
        nii_ima_fego{sub,session} = temp_1d_fego;
        nii_ima_fangle{sub,session} = temp_1d_fangle;
    end
end


nii_imas_fmap= cell(26,4);
nii_imas_fed= cell(26,4);
nii_imas_ffdo= cell(26,4);
nii_imas_ftdo= cell(26,4);
nii_imas_ffdo_location= cell(26,4);
nii_imas_ftdo_location= cell(26,4);
nii_imas_fego = cell(26,4);
nii_imas_fangle = cell(26,4);

for sub = 8:26
    for session = 1:4
        output_table =  create_volumn_table_each_session_fsl(global_path, sub, session, sub_folder_name);
        mask_volume = output_table{1,1}.vol;
        [d1, d2, d3] = ind2sub( size(mask_volume),find(mask_volume~=0));
        count_voxel = length(d1);
        volume_fmap = zeros(size(mask_volume));
        volume_fed =zeros(size(mask_volume));
        volume_ffdo = zeros(size(mask_volume));
        volume_ftdo = zeros(size(mask_volume));
        volume_ffdo_location = zeros(size(mask_volume));
        volume_ftdo_location = zeros(size(mask_volume));
        volume_fego = zeros(size(mask_volume));
        volume_fangle = zeros(size(mask_volume));
        for voxel =  1:count_voxel
            volume_fmap(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_fmap{sub,session}(voxel);
            volume_fed(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_fed{sub,session}(voxel);
            volume_ffdo(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_ffdo{sub,session}(voxel);
            volume_ftdo(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_ftdo{sub,session}(voxel);
            volume_ffdo_location(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_ffdo_location{sub,session}(voxel);
            volume_ftdo_location(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_ftdo_location{sub,session}(voxel);
            volume_fego(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_fego{sub,session}(voxel);
            volume_fangle(d1(voxel),d2(voxel),d3(voxel)) = nii_ima_fangle{sub,session}(voxel);
        end
        
        output_table{1,1}.vol = volume_fmap;
        output_table{2,1}.vol = volume_fed;
        output_table{3,1}.vol = volume_ffdo;
        output_table{4,1}.vol = volume_ftdo;
        output_table{5,1}.vol = volume_ffdo_location;
        output_table{6,1}.vol = volume_ftdo_location;
        output_table{7,1}.vol = volume_fego;
        output_table{8,1}.vol = volume_fangle;
        nii_imas_fmap{sub,session}= output_table{1,1};
        nii_imas_fed{sub,session}= output_table{2,1};
        nii_imas_ffdo{sub,session}= output_table{3,1};
        nii_imas_ftdo{sub,session}= output_table{4,1};
        nii_imas_ffdo_location{sub,session}= output_table{5,1};
        nii_imas_ftdo_location{sub,session}= output_table{6,1};
        nii_imas_fego{sub,session}= output_table{7,1};
        nii_imas_fangle{sub,session}= output_table{8,1};
        disp([num2str(sub),'-',num2str(session)]);
    end
end

for sub= 8:26
    for session =1:4
        mkdir([global_path,'/analysis_mvpa/fsl_glm_',  sub_folder_name ,'map_session', num2str(session)]);
        MRIwrite(nii_imas_fmap{sub,session},[global_path,'/analysis_mvpa/fsl_glm_',  sub_folder_name ,'map_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'/analysis_mvpa/fsl_glm_',  sub_folder_name ,'ed_session', num2str(session)]);
        MRIwrite(nii_imas_fed{sub,session},[global_path,'/analysis_mvpa/fsl_glm_',  sub_folder_name ,'ed_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'/analysis_mvpa/fsl_glm_',  sub_folder_name ,'fdo_session', num2str(session)]);
        MRIwrite(nii_imas_ffdo{sub,session},[global_path,'/analysis_mvpa/fsl_glm_',  sub_folder_name ,'fdo_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'/analysis_mvpa/fsl_glm_',  sub_folder_name ,'tdo_session', num2str(session)]);
        MRIwrite(nii_imas_ftdo{sub,session},[global_path,'/analysis_mvpa/fsl_glm_',  sub_folder_name ,'tdo_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'/analysis_mvpa/fsl_glm_',  sub_folder_name ,'fdo_location_session', num2str(session)]);
        MRIwrite(nii_imas_ffdo_location{sub,session},[global_path,'/analysis_mvpa/fsl_glm_',  sub_folder_name ,'fdo_location_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'/analysis_mvpa/fsl_glm_',  sub_folder_name ,'tdo_location_session', num2str(session)]);
        MRIwrite(nii_imas_ftdo_location{sub,session},[global_path,'/analysis_mvpa/fsl_glm_',  sub_folder_name ,'tdo_location_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);
        
        mkdir([global_path,'/analysis_mvpa/fsl_glm_',  sub_folder_name ,'ego_session', num2str(session)]);
        MRIwrite(nii_imas_fego{sub,session},[global_path,'/analysis_mvpa/fsl_glm_',  sub_folder_name ,'ego_session', num2str(session),  '/sub',num2str(sub), '_s', num2str(session),'.nii']);

    end
end











