
function ct_by_voxel_spm

global_path = '/gpfs/share/home/1401110602/fmri_script';
ct_path = '/mvpa_facing_mft/';
individual_folder = '/mvpa_facing/';

%%  3d corr_matrix
for sub = 8:26
    output_table = create_volumn_table(global_path, sub, individual_folder);
    count_trialtype = length(output_table(:,1));
    sphere_coordinate = sphericalRelativeRoi(6,[2,2,2]);
    [mask_brain, mask_coor] = spm_read_vols(spm_vol([global_path,'/custom_script/atlas_official/rwhole_brain_mask.nii']));
    [d1, d2, d3] = ind2sub(size(mask_brain),find(mask_brain==1));
    voxel_array = [d1, d2, d3];
    count_voxel = length(voxel_array);
    corr_3d_array = nan(count_trialtype, count_trialtype, count_voxel);
    parfor (voxel_index = 1:count_voxel)
        sphere = repmat(voxel_array(voxel_index,:), size(sphere_coordinate,1), 1) + sphere_coordinate;
        [row_ind, col_ind] = find(sphere < 1);
        sphere (row_ind, :) = [];
        eachSphere_by_trial = nan(length(sphere(:,1)), count_trialtype);
        for trialtype = 1:count_trialtype
            ima = output_table{trialtype,1};
            for ith = 1:length(sphere(:,1))
                eachSphere_by_trial(ith, trialtype) = ima(sphere(ith,1), sphere(ith,2), sphere(ith,3));
            end
        end
        eachSphere_by_trial(find(isnan(eachSphere_by_trial(:,1))),:)=[];
        if(isempty(eachSphere_by_trial) | length(eachSphere_by_trial(:,1))<10)
            corr_3d_array(:,:,voxel_index) = nan(count_trialtype, count_trialtype);
        else
            [rho,pval] = corr(eachSphere_by_trial, 'Type','Pearson');
            corr_3d_array(:,:,voxel_index) = rho;
        end
        disp( ['corr_matrix -- sub-',num2str(sub), '-voxel-',num2str(voxel_index)]);
    end
    save([global_path, ct_path, 'sub' , num2str(sub), '_6mm' '.mat'],'-v7.3');
end






