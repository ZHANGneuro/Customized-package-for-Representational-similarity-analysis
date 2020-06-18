

% step1 
% save to 3d matrix,  2d correlation matrix, 3d means voxel.

clear;
global_path =  '/Users/boo/Documents/degree_PhD/data_fmri';
folder_name='w8s_lc_s';
keyw='w8s_lc_';

for sub =8:26
    for session = 1:4
        ct_path = ['/', folder_name, num2str(session),'/'];
        mkdir([global_path,'/', folder_name, num2str(session) ]);
        output_table = create_volumn_table_each_session_fsl(global_path, sub,session, keyw);  % create_volumn_table_each_session_mdf_fsl   create_volumn_table_each_session_walking_fsl
        count_trialtype =  length(output_table(:,1));
        spherec_coordinate = sphericalRelativeRoi(6,[2 2 2.3]);
        mask_brain = output_table{1,1}.vol;
        [fir_di, sec_di, thi_di] = size(mask_brain);
        [d1, d2, d3] = ind2sub([fir_di, sec_di, thi_di],find(mask_brain~=0));
        voxel_array = [d1, d2, d3];
        count_voxel = length(voxel_array);
        corr_3d_array = nan(count_trialtype, count_trialtype, count_voxel);
        parfor (voxel_index = 1:count_voxel)
            spherec = repmat(voxel_array(voxel_index,:), size(spherec_coordinate,1), 1) + spherec_coordinate;
            [row_ind, col_ind] = find(spherec(:,1) < 1 | spherec(:,2) < 1 | spherec(:,3) < 1 | spherec(:,1)>fir_di | spherec(:,2)>sec_di | spherec(:,3)>thi_di);
            spherec (row_ind, :) = [];
            eachspherec_by_trial = nan(length(spherec(:,1)), count_trialtype);
            
%             temp_strct = output_table{1,1};
%             temp_brain = output_table{1,1}.vol;
%             for ith = 1:length(spherec(:,1))
%                 temp_brain(spherec(ith,1), spherec(ith,2), spherec(ith,3)) = 1000;
%             end
%             temp_strct.vol = temp_brain;
%             MRIwrite(temp_strct,'/Users/boo/Desktop/for_searchlight_show.nii');
            
            for trialtype_th = 1:count_trialtype
                ima = output_table{trialtype_th,1}.vol;
                for ith = 1:length(spherec(:,1))
                    eachspherec_by_trial(ith, trialtype_th) = ima(spherec(ith,1), spherec(ith,2), spherec(ith,3));
                end
            end
            eachspherec_by_trial(find(isnan(eachspherec_by_trial(:,1)) | eachspherec_by_trial(:,1)==0),:)=[];
            if(isempty(eachspherec_by_trial) | length(eachspherec_by_trial(:,1))<10)
                corr_3d_array(:,:,voxel_index) = nan(count_trialtype, count_trialtype);
            else
                [rho,pval] = corr(eachspherec_by_trial, 'Type','Pearson');
                t_rho = 0.5 * (log((1+rho)./(1-rho)));
                corr_3d_array(:,:,voxel_index) = t_rho;
            end
            disp( ['corr_matrix -- sub-',num2str(sub), '-voxel-',num2str(voxel_index)]);
        end
        save([global_path, ct_path, 'sub' , num2str(sub), '_6mm_s', num2str(session),'.mat'], 'corr_3d_array', '-v7.3');
        clear output_table;
        clear mask_brain;
        clear corr_3d_array;
    end
end








