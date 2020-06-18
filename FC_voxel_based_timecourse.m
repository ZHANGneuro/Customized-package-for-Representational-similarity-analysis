

global_path = '/Users/boo/Documents/degree_PhD/data_fmri'; % global_path =  '/Users/boo/Desktop/fmri_script/';
cluster_path = [global_path, '/analysis_FC_mtl_hand_aal/'];
cluster_dir = dir(fullfile(cluster_path, 'folder*'));
cluster_list = {cluster_dir.name}';

ima_4d_root = '/Users/boo/Documents/degree_PhD/data_fmri/residual_fc_5mm_derivative_bandpass/';
ima_4d_dir = dir(fullfile(ima_4d_root, '*.nii'));
ima_4d_pool =  strcat(ima_4d_root, {ima_4d_dir.name}');

for ith_cluster = 1:length(cluster_list)
    
    roi_name = cluster_list{ith_cluster};
    target_folder_walking_eariler = [cluster_path, 'period_walking_earlier/r_map_', roi_name];
    target_folder_walking_late = [cluster_path, 'period_walking_late/r_map_', roi_name];
    target_folder_facing = [cluster_path, 'period_facing/r_map_', roi_name];
    target_folder_targeting = [cluster_path, 'period_targeting/r_map_', roi_name];
    if ~exist(target_folder_walking_eariler, 'dir')
        mkdir(target_folder_walking_eariler);
    end
    if ~exist(target_folder_walking_late, 'dir')
        mkdir(target_folder_walking_late);
    end
    if ~exist(target_folder_facing, 'dir')
        mkdir(target_folder_facing);
    end
    if ~exist(target_folder_targeting, 'dir')
        mkdir(target_folder_targeting);
    end
    
    roi_timeseries_path = [cluster_path, roi_name];
    roi_timeseries_dir = dir(fullfile(roi_timeseries_path, '*.txt'));
    roi_timeseries_pool =  strcat(roi_timeseries_path, '/',{roi_timeseries_dir.name}');
    
    for ith_roi_timeseries= 1:length(roi_timeseries_pool)
        
        path_timeseries =roi_timeseries_pool{ith_roi_timeseries};
        path_roi = fopen(path_timeseries,'r');
        roi_series = textscan(path_roi,'%s');
        roi_series = str2double(roi_series{1});
        fclose(path_roi);
        
        ima_4d_path = ima_4d_pool{ith_roi_timeseries};
        ima_4d_struct = MRIread(ima_4d_path);
        ima_4d = ima_4d_struct.vol;
        
        temp = extractBetween(path_timeseries, 'timecourse_', 'txt');
        sub = extractBetween(temp,  'sub', '_s');
        session = extractBetween(temp, '_s', '.');
        sub = str2num(sub{1});
        session = str2num(session{1});
        
        [~, table_time] = extract_behavioral_table_fmri(global_path, sub);
        col_count_raw_time = length(table_time(1,:));
        raw_time_by_session = cell(1,col_count_raw_time);
        for each_col = 1:col_count_raw_time
            raw_time_by_session{1, each_col} = table_time{1, each_col}(find( ...
                cellfun(@(x,y)  ~strcmp(x, 'NA') & strcmp(y, num2str(session)), ...
                table_time{1,12}, table_time{1,13})));
        end
        
        num_row = length(raw_time_by_session{1,1});
        num_col = length(raw_time_by_session(1,:));
        txt_matrix=nan(num_row, num_col);
        for ith_txtcol = 1: num_col
            for ith_txtrow = 1: num_row
                txt_matrix(ith_txtrow, ith_txtcol) = str2num(raw_time_by_session{1, ith_txtcol}{ith_txtrow});
            end
        end
        txt_matrix = txt_matrix(:,[2, 4:11]);
        txt_matrix = txt_matrix* 0.001-6;
        TR_ith_matrix = round(txt_matrix/2);
        TR_ith_matrix( find(TR_ith_matrix(:,1)<0), 1) = 0;
        TR_ith_matrix = TR_ith_matrix + 1;
        TR_ith_matrix = TR_ith_matrix + 2;
        TR_ith_matrix(:,6:11) = TR_ith_matrix(:,4:9);
        TR_ith_matrix(:,4) = TR_ith_matrix(:,3)+1;
        TR_ith_matrix(:,5) = TR_ith_matrix(:,4)+1;
        
        TR_series_walking_eariler = [];
        TR_series_walking_late = [];
        TR_series_facing = [];
        TR_series_targeting = [];
        %         temp_matrix_walking_eariler =  TR_ith_matrix(:,[1 2]);
        temp_matrix_walking_eariler =  TR_ith_matrix(:,[3 4]);
        temp_matrix_walking_late =  TR_ith_matrix(:,[5 6]);
        temp_matrix_facing =  TR_ith_matrix(:,[7 8]);
        temp_matrix_targeting =  TR_ith_matrix(:,[9 10]);
        for trans_ith = 1:length(temp_matrix_walking_eariler(:,1))
            TR_series_walking_eariler = [TR_series_walking_eariler; temp_matrix_walking_eariler(trans_ith, :)'];
            TR_series_walking_late = [TR_series_walking_late; temp_matrix_walking_late(trans_ith, :)'];
            TR_series_facing = [TR_series_facing; temp_matrix_facing(trans_ith, :)'];
            TR_series_targeting = [TR_series_targeting; temp_matrix_targeting(trans_ith, :)'];
        end
        
        roi_series_walking_eariler = roi_series(TR_series_walking_eariler);
        roi_series_walking_late = roi_series(TR_series_walking_late);
        roi_series_facing = roi_series(TR_series_facing);
        roi_series_targeting = roi_series(TR_series_targeting);
        ima4d_series_walking_eariler = ima_4d(:,:,:,TR_series_walking_eariler);
        ima4d_series_walking_late = ima_4d(:,:,:,TR_series_walking_late);
        ima4d_series_facing = ima_4d(:,:,:,TR_series_facing);
        ima4d_series_targeting = ima_4d(:,:,:,TR_series_targeting);
        
        mean_ima4d = mean(ima_4d,4);
        [d1, d2, d3] = ind2sub(size(mean_ima4d),find(mean_ima4d~=0));
        ith_nonzero = find(mean_ima4d~=0);
        temp_1d_ima_walking_eariler = zeros(length(d1), 1);
        temp_1d_ima_walking_late = zeros(length(d1), 1);
        temp_1d_ima_facing = zeros(length(d1), 1);
        temp_1d_ima_targeting = zeros(length(d1), 1);
        empty_ima = ima_4d(:,:,:,1);
        empty_ima(:) = 0;
        empty_ima_walking_eariler=empty_ima;
        empty_ima_walking_late=empty_ima;
        empty_ima_facing=empty_ima;
        empty_ima_targeting=empty_ima;
        parfor (ith_voxel = 1:length(d1), 6)
            voxelseries_4d_walking_eariler = ima4d_series_walking_eariler(d1(ith_voxel), d2(ith_voxel), d3(ith_voxel), :);
            voxelseries_4d_walking_late = ima4d_series_walking_late(d1(ith_voxel), d2(ith_voxel), d3(ith_voxel), :);
            voxelseries_4d_facing = ima4d_series_facing(d1(ith_voxel), d2(ith_voxel), d3(ith_voxel), :);
            voxelseries_4d_targeting = ima4d_series_targeting(d1(ith_voxel), d2(ith_voxel), d3(ith_voxel), :);
            voxelseries_4d_walking_eariler = voxelseries_4d_walking_eariler(:);
            voxelseries_4d_walking_late = voxelseries_4d_walking_late(:);
            voxelseries_4d_facing = voxelseries_4d_facing(:);
            voxelseries_4d_targeting = voxelseries_4d_targeting(:);
            RHO_walking_eariler = corr([roi_series_walking_eariler voxelseries_4d_walking_eariler]);
            RHO_walking_late = corr([roi_series_walking_late voxelseries_4d_walking_late]);
            RHO_facing = corr([roi_series_facing voxelseries_4d_facing]);
            RHO_targeting = corr([roi_series_targeting voxelseries_4d_targeting]);
            temp_1d_ima_walking_eariler(ith_voxel, 1) = RHO_walking_eariler(2);
            temp_1d_ima_walking_late(ith_voxel, 1) = RHO_walking_late(2);
            temp_1d_ima_facing(ith_voxel, 1) = RHO_facing(2);
            temp_1d_ima_targeting(ith_voxel, 1) = RHO_targeting(2);
            [num2str(ith_cluster), '-' ,num2str(ith_roi_timeseries), '-', num2str(ith_voxel)]
        end
        empty_ima_walking_eariler(ith_nonzero) = 0.5 * (log((1+temp_1d_ima_walking_eariler)./(1-temp_1d_ima_walking_eariler)));
        empty_ima_walking_late(ith_nonzero) = 0.5 * (log((1+temp_1d_ima_walking_late)./(1-temp_1d_ima_walking_late)));
        empty_ima_facing(ith_nonzero) = 0.5 * (log((1+temp_1d_ima_facing)./(1-temp_1d_ima_facing)));
        empty_ima_targeting(ith_nonzero) = 0.5 * (log((1+temp_1d_ima_targeting)./(1-temp_1d_ima_targeting)));
        ima_4d_struct.vol=empty_ima_walking_eariler;
        MRIwrite(ima_4d_struct,[target_folder_walking_eariler, '/sub_', num2str(sub), '_s',  num2str(session), '.nii']);
        ima_4d_struct.vol=empty_ima_walking_late;
        MRIwrite(ima_4d_struct,[target_folder_walking_late, '/sub_', num2str(sub), '_s',  num2str(session), '.nii']);
        ima_4d_struct.vol=empty_ima_facing;
        MRIwrite(ima_4d_struct,[target_folder_facing, '/sub_', num2str(sub), '_s',  num2str(session), '.nii']);
        ima_4d_struct.vol=empty_ima_targeting;
        MRIwrite(ima_4d_struct,[target_folder_targeting, '/sub_', num2str(sub), '_s',  num2str(session), '.nii']);
    end
end
