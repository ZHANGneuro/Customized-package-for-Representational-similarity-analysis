% function split_bandpass_residual_into_period

global_path = '/Users/boo/Documents/degree_PhD/data_fmri/'; % global_path =  '/gpfs/share/home/1401110602/fmri_script/';
ima_4d_root = '/Users/boo/Documents/degree_PhD/data_fmri/residual_fc_5mm_derivative_bandpass/';
ima_4d_dir = dir(fullfile(ima_4d_root, '*.nii'));
ima_4d_pool =  strcat(ima_4d_root, {ima_4d_dir.name}');


for ith_residual= 71:length(ima_4d_pool)
    
    ima_4d_path = ima_4d_pool{ith_residual};
    ima_4d_struct = MRIread(ima_4d_path);
    ima_4d = ima_4d_struct.vol;
    
    
    temp = extractBetween(ima_4d_path, 'bandpass_', 'nii');
    temp = temp{1};
    sub = extractBetween(temp,  'sub', '_s');
    session = extractBetween(temp, '_s', '.');
    sub = str2num(sub{1});
    session = str2num(session{1});
    
    % load behavior data, load into matrix, make it seconds
    [~, table_time] = extract_behavioral_table(global_path, sub);
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
    
    TR_series_blank = [];
    TR_series_walking = [];
    TR_series_facing = [];
    TR_series_targeting = [];
    temp_matrix_blank =  TR_ith_matrix(:,[1 2]);
    temp_matrix_walking =  TR_ith_matrix(:,[3 4 5 6]);
    temp_matrix_facing =  TR_ith_matrix(:,[7 8]);
    temp_matrix_targeting =  TR_ith_matrix(:,[9 10]);
    for ith = 1:length(temp_matrix_blank(:,1))
        TR_series_blank = [TR_series_blank; temp_matrix_blank(ith, :)'];
        TR_series_walking = [TR_series_walking; temp_matrix_walking(ith, :)'];
        TR_series_facing = [TR_series_facing; temp_matrix_facing(ith, :)'];
        TR_series_targeting = [TR_series_targeting; temp_matrix_targeting(ith, :)'];
    end
    

%     empty_ima_blank = ima_4d(:,:,:, TR_series_blank);
    empty_ima_walking = ima_4d(:,:,:, TR_series_walking);
%     empty_ima_facing = ima_4d(:,:,:, TR_series_facing);
%     empty_ima_targeting = ima_4d(:,:,:, TR_series_targeting);
    
   
%     ima_4d_struct.vol=empty_ima_blank;
%     MRIwrite(ima_4d_struct,['/Users/boo/Desktop/fmri_script/residual_fc_5mm_derivative_bandpass_blank/', 'fc_bandpass_sub_', num2str(sub), '_s',  num2str(session), '.nii']);
    ima_4d_struct.vol=empty_ima_walking;
    MRIwrite(ima_4d_struct,['/Users/boo/Desktop/fmri_script/residual_fc_5mm_derivative_bandpass_walking/', 'fc_bandpass_sub_', num2str(sub), '_s',  num2str(session), '.nii']);
%     ima_4d_struct.vol=empty_ima_facing;
%     MRIwrite(ima_4d_struct,[target_folder_facing, '/sub_', num2str(sub), '_s',  num2str(session), '.nii']);
%     ima_4d_struct.vol=empty_ima_targeting;
%     MRIwrite(ima_4d_struct,[target_folder_targeting, '/sub_', num2str(sub), '_s',  num2str(session), '.nii']);

ith_residual


end


