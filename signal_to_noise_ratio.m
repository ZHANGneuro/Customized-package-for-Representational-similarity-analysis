



%% output nii from dicom
for ith_sub = 8:26
    for ith_sess = 1:4
        target_folder_path = ['/Users/boo/Documents/degree_PhD/data_fmri/NAYA', num2str(ith_sub), '/bold_run', num2str(ith_sess), '/'];
        dicm2nii(target_folder_path, target_folder_path, 1)
    end
end


%% cp
for ith_sub = 8:26
    for ith_sess = 1:4
        target_folder_path = ['/Users/boo/Documents/degree_PhD/data_fmri/NAYA', num2str(ith_sub), '/bold_run', num2str(ith_sess), '/sms_bold_run', num2str(ith_sess), '.nii.gz'];
        copyfile(target_folder_path, ['/Users/boo/Documents/degree_PhD/data_fmri/4d_nii/sub', num2str(ith_sub), '_s', num2str(ith_sess), '.nii.gz'])
    end
end



export_table_mtl =zeros (26,4);
export_table_mpfc =zeros (26,4);
for ith_sub = 8:26
    for ith_sess = 1:4
        
        struct_ima = MRIread(['/Users/boo/Documents/degree_PhD/data_fmri/4d_nii/sub', num2str(ith_sub),'_s', num2str(ith_sess),'.nii']);

        vol_ima = struct_ima.vol;
        
        processed_ima = vol_ima;
        mean_ima = mean(processed_ima, 4);
        size_4d=size(processed_ima);

        struct_noise = MRIread(['/Users/boo/Documents/degree_PhD/data_fmri/brainmask/roi_native_noise/sub', num2str(ith_sub),'_s', num2str(ith_sess),'.nii.gz']);
        vol_noise = struct_noise.vol;
        noise_index = find(vol_noise==1);
        num_slice = size_4d(4);
        num_noise_vol = length(noise_index);
        noise_array = zeros(num_noise_vol, num_slice);
        
        for ith_slice = 1:num_slice
            curr_slice = processed_ima(:, :, :, ith_slice);
            noise_array(:, ith_slice) = curr_slice(noise_index);
        end
        std_noise= std(noise_array, 0, 2);
        snr = mean_ima/mean(std_noise);
        
        struct_mpfc = MRIread(['/Users/boo/Documents/degree_PhD/data_fmri/brainmask/roi_native_mpfc/sub', num2str(ith_sub),'_s', num2str(ith_sess),'.nii.gz']);
        vol_mpfc = struct_mpfc.vol;
        index_mpfc = find(vol_mpfc==1);
        
        struct_mtl = MRIread(['/Users/boo/Documents/degree_PhD/data_fmri/brainmask/roi_native_mtl/sub', num2str(ith_sub),'_s', num2str(ith_sess),'.nii.gz']);
        vol_mtl = struct_mtl.vol;
        index_mtl = find(vol_mtl==1);
        
        snr_mpfc = snr(index_mpfc);
        snr_mtl = snr(index_mtl);

        export_table_mtl(ith_sub, ith_sess) = mean(snr_mtl);
        export_table_mpfc(ith_sub, ith_sess) = mean(snr_mpfc);
        [num2str(ith_sub), '_', num2str(ith_sess)]
    end
end
mean_mtl = mean(export_table_mtl, 2);
mean_mpfc = mean(export_table_mpfc, 2);
value_mean_mtl = mean(mean_mtl(8:26));
value_mean_mpfc = mean(mean_mpfc(8:26));
value_std_mtl = std(mean_mtl(8:26));
value_std_mpfc = std(mean_mpfc(8:26));




%% mean/sd
for ith_sub = 8:26
    for ith_sess = 1:4
        
%         struct_ima = MRIread(['/Users/boo/Documents/degree_PhD/data_fmri/4d_nii/sub', num2str(ith_sub),'_s', num2str(ith_sess),'.nii']);
        struct_ima = MRIread(['/Users/boo/Documents/degree_PhD/data_fmri/4d_nii/sub', num2str(ith_sub),'_s', num2str(ith_sess),'.nii']);

        vol_ima = struct_ima.vol;
        size_4d=size(vol_ima);
        num_slice = size_4d(4);
        
        
        mean_ima = mean(vol_ima, 4);
        std_ima= std(vol_ima, 0, 4);
        snr = mean_ima./std_ima;
        

        struct_mpfc = MRIread(['/Users/boo/Documents/degree_PhD/data_fmri/brainmask/roi_native_mpfc/sub', num2str(ith_sub),'_s', num2str(ith_sess),'.nii.gz']);
        vol_mpfc = struct_mpfc.vol;
        index_mpfc = find(vol_mpfc==1);
        
        struct_mtl = MRIread(['/Users/boo/Documents/degree_PhD/data_fmri/brainmask/roi_native_mtl/sub', num2str(ith_sub),'_s', num2str(ith_sess),'.nii.gz']);
        vol_mtl = struct_mtl.vol;
        index_mtl = find(vol_mtl==1);
        
        snr_mpfc = snr(index_mpfc);
        snr_mtl = snr(index_mtl);
        
        mean(snr_mpfc)
        mean(snr_mtl)
        
        
    end
end





