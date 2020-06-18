

%% rsa activity for p2
aal_roi_pool = load_aal_label51;
voxel_threshold = 20;

input_path = '/Users/boo/Desktop/MEG_data_script/result_MRI_ego_figure/';
input_dir = dir(fullfile(input_path, 'lr-b_clustere_corrp*'));
input_pool =  strcat(input_path,{input_dir.name}');

export_table = cell(length(input_pool), 1);

for ith_input_ima= 1:length(input_pool)
    
    input_ima_path = input_pool{ith_input_ima};
    
    % ima name
    info_name = extractBetween(input_ima_path, 'result_MRI_ego_figure/', '_clustere_corrp');
    info_name = info_name{1};
    
    % input ima
    input_ima_strct = MRIread(input_ima_path);
    input_ima=input_ima_strct.vol;
    input_ima(find(input_ima<=0.95))=0;
    input_ima(find(input_ima>0.95))=1;
    
    agent_table = cell(200, 4);
    ith_row = 1;
    % each anatomy
    for ith_sub_mask = 1:length(aal_roi_pool(:,1))
        
        mask_path=aal_roi_pool{ith_sub_mask,1};
        mask_hemisphere = aal_roi_pool{ith_sub_mask,2};
        mask_strct = MRIread(mask_path);
        mask_ima = mask_strct.vol;
        indexes_mask = find(mask_ima>0);
        
        % iter cluster
        cc = arrayfun(@(x) bwconncomp(bsxfun(@gt,input_ima,x),6), 0);
        final_index=[];
        for each_cluster = 1:cc.NumObjects
            indexes_cluster = cc.PixelIdxList{each_cluster};
            final_index = [final_index; indexes_mask(find(ismember(indexes_mask,indexes_cluster)))];
        end
        final_index = unique(final_index);
        
        if length(final_index) > voxel_threshold
            
            % mask name
            mask_name = extractBetween(mask_path, 'aal_51/', '.nii');
            mask_name =mask_name{1};
            agent_table{ith_row, 4} = mask_name;
            
            % number of voxel
            agent_table{ith_row, 1} = length(final_index);
            
            % get t image
            t_ima_dir = dir(fullfile(input_path, 'lr-b_tstat1*'));
            t_ima_pool =  strcat(input_path, {t_ima_dir.name}');
            temp_name = info_name; %strsplit(info_name, '_');
            %temp_name = temp_name{2};
            t_ima_ind = find(cellfun(@(x) contains(x, temp_name), t_ima_pool));
            t_ima_path = t_ima_pool{t_ima_ind};
            t_ima_strct = MRIread(t_ima_path);
            t_ima = t_ima_strct.vol;
            
            % get peak
            max_t_val = max(t_ima(final_index));
            max_t_val_index = find(t_ima==max_t_val);
            
            agent_table{ith_row, 2} = round(max_t_val,2);
            % coordinate but not mni
            [d1, d2, d3] = ind2sub(size(t_ima),max_t_val_index);
            mni_coordinate = [ d2-1 d1-1 d3-1];
            
            % convert coordinate
            [mni_x mni_y mni_z outtype] = cor2mni(mni_coordinate(1), mni_coordinate(2), mni_coordinate(3), 2,'xyz');
            agent_table{ith_row, 3} = ['[', num2str(mni_x), ', ', num2str(mni_y), ', ' num2str(mni_z), ']'];
            
            [num2str(ith_input_ima), '_', num2str(each_cluster), '_', num2str(ith_sub_mask)]
            ith_row = ith_row + 1;
        end
    end
    
    agent_table(find(cellfun(@(x) isempty(x), agent_table(:,4))),:)=[];
    [B,I] = sortrows(agent_table(:,[2,1]),'descend');
    agent_table = agent_table(I,:);
    export_table{ith_input_ima, 1} = agent_table;
    export_table{ith_input_ima, 2} = info_name;
end


















%% rsa
aal_roi_pool = load_aal_label;
voxel_threshold = 20;

input_path = '/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/filtered_201907chaslocation361/aal_corrected_rsa/';
input_dir = dir(fullfile(input_path, 'correc*'));
input_pool =  strcat(input_path,{input_dir.name}');

export_table = cell(length(input_pool), 1);

for ith_input_ima= 1:length(input_pool)
    
    input_ima_path = input_pool{ith_input_ima};
    
    % ima name
    info_name = extractBetween(input_ima_path, '/corrected_', '.nii');
    info_name = info_name{1};
    
    % input ima
    input_ima_strct = MRIread(input_ima_path);
    input_ima=input_ima_strct.vol;
    input_ima(find(input_ima<=0.95))=0;
    input_ima(find(input_ima>0.95))=1;
    
    nvox = length(input_ima(:));
    cc = arrayfun(@(x) bwconncomp(bsxfun(@gt,input_ima,x),6), 0);
    array_for_numVoxel_eachCluster = cellfun(@numel,cc.PixelIdxList);
    agent_table = cell(cc.NumObjects, 4);
    for each_cluster = 1:cc.NumObjects
        if array_for_numVoxel_eachCluster(each_cluster)>voxel_threshold
            indexes = cc.PixelIdxList{each_cluster};
            
            % number of voxel
            agent_table{each_cluster, 1} = length(indexes);
            
            % get peak
            t_ima_dir = dir(fullfile('/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/filtered_201907chaslocation361/', 'wr_tval*'));
            t_ima_pool =  strcat('/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/filtered_201907chaslocation361/', {t_ima_dir.name}');
            temp_name = strsplit(info_name, '_');
            temp_name = temp_name{2};
            t_ima_ind = find(cellfun(@(x) contains(x, temp_name), t_ima_pool));
            t_ima_path = t_ima_pool{t_ima_ind};
            t_ima_strct = MRIread(t_ima_path);
            t_ima = t_ima_strct.vol;
            max_t_val = max(t_ima(indexes));
            max_t_val_index = find(t_ima==max_t_val);
            agent_table{each_cluster, 2} = round(max_t_val,2);
            % coordinate but not mni
            [d1, d2, d3] = ind2sub(size(t_ima),find(t_ima==max_t_val));
            mni_coordinate = [ d2-1 d1-1 d3-1];
            agent_table{each_cluster, 3} = mni_coordinate;
            
            % convert coordinate
            [mni_x mni_y mni_z outtype] = cor2mni(mni_coordinate(1), mni_coordinate(2), mni_coordinate(3), 2,'xyz');
            agent_table{each_cluster, 4} = ['[', num2str(mni_x), ', ', num2str(mni_y), ', ' num2str(mni_z), ']'];
            
            % each anatomy
            for ith_sub_mask = 1:length(aal_roi_pool(:,1))
                
                mask_path=aal_roi_pool{ith_sub_mask,1};
                mask_strct = MRIread(mask_path);
                mask_ima = mask_strct.vol;
                mask_ima(find(mask_ima>0))=1;
                
                if mask_ima(max_t_val_index)>0
                    % hemisphere
                    mask_hemisphere = aal_roi_pool{ith_sub_mask,2};
                    %                     agent_table{each_cluster, 4} = mask_hemisphere;
                    % parent
                    %agent_table{each_cluster, 5} = aal_roi_pool{ith_sub_mask,3};
                    % mask name
                    mask_name = extractBetween(mask_path, 'aal_102/', ['_', mask_hemisphere(1)]);
                    mask_name =mask_name{1};
                    agent_table{each_cluster, 5} = mask_name;
                    [num2str(ith_input_ima), '_', num2str(each_cluster), '_', num2str(ith_sub_mask)]
                end
            end
        end
    end
    agent_table(find(cellfun(@(x) isempty(x), agent_table(:,4))),:)=[];
    [B,I] = sortrows(agent_table(:,[2,5]),'descend');
    agent_table = agent_table(I,:);
    export_table{ith_input_ima, 1} = agent_table;
    export_table{ith_input_ima, 2} = info_name;
end

















%%

% aal_path = '/Users/boo/Documents/degree_PhD/data_fmri/brainmask/aal/aal_102/';
% aal_dir = dir(fullfile(aal_path, '*.nii'));
% aal_dir =  strcat(aal_path,{aal_dir.name}');
% aal_full = zeros(109,91,91);
% for ith_all = 1:length(aal_dir)
%     temp_struct = MRIread(aal_dir{ith_all});
%     temp_ima = temp_struct.vol;
%     aal_full = aal_full+temp_ima;
% end
%
%
% input_path = '/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/filtered_201907chaslocation361/aal_corrected_rsa/';
% input_dir = dir(fullfile(input_path, 'wr_fsl*'));
% input_pool =  strcat(input_path,{input_dir.name}');
%
% for ith_info = 1:length(input_pool)
%     curr_info = input_pool{ith_info};
%     temp_list = strsplit(curr_info, 'wr_fsl_');
%     temp_struct = MRIread(curr_info);
%     temp_ima = temp_struct.vol;
%     temp_ima(find(temp_ima<=0.95))=0;
%     temp_ima(find(temp_ima>0.95))=0.5;
%
%     test_ima = temp_ima+aal_full;
%     test_ima(find(test_ima<1.5))=0;
%     test_ima(find(test_ima==1.5))=1;
%     temp_struct.vol = test_ima;
%     MRIwrite(temp_struct, [temp_list{1}, 'corrected_', temp_list{2}]);
% end

