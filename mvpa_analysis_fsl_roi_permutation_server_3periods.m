

%% get basic table
clear;

global_path ='/Users/boo/Documents/degree_PhD/data_fmri';

roi_folder_path= [global_path, '/analysis_MVPA_roi'];
brain_dir = dir(fullfile(roi_folder_path, 'folder_both_*'));
brain_dir = strcat(roi_folder_path,  '/' ,{brain_dir.name}');

%info_list = {'map', 'ed', 'fcha', 'tcha', 'selfo', 'tcha_location', 'ego'};
info_list = {'map', 'selfo', 'ego'};
% info_list = {'selfo'};
num_value_col = 4;
% period_list = {'w8s_lc_', 'f4s_lc_', 't4s_lc_'};
period_list = {'f4s_lc_', 't4s_lc_'};


roi_table = cell(length(brain_dir),2);
num_shuffle = 5000;

for ith_roi_path = 1:length(brain_dir)
    
    file_dir = dir(fullfile(brain_dir{ith_roi_path}, 'sub*'));
    file_dir = strcat(brain_dir{ith_roi_path},  '/' ,{file_dir.name}');
    
    roi_table_sub = cell(length(brain_dir)*length(info_list)*length(period_list),6);
    roi_table{ith_roi_path,2} = brain_dir{ith_roi_path};
    str_pool = strsplit(brain_dir{ith_roi_path},'folder_both_');
    roi_table{ith_roi_path,3} = str_pool{2};
    
    indic = 1;
    for ith_file_path = 1:length(file_dir)
        for ith_info = 1:length(info_list)
            for ith_period = 1:length(period_list)
                
                roi_table_sub{indic,1} = file_dir{ith_file_path};
                
                region = extractBetween(file_dir{ith_file_path}, 'folder_both_', '/sub');
                subj = extractBetween(file_dir{ith_file_path}, '/sub', '_s');
                sess=  extractBetween(file_dir{ith_file_path}, [subj{1}, '_s'], '.nii');
                
                roi_table_sub{indic,2} = region{1};
                roi_table_sub{indic,3} = subj{1};
                roi_table_sub{indic,4} = sess{1};
                roi_table_sub{indic,5} = info_list{ith_info};
                roi_table_sub{indic,6} = period_list{ith_period};
                indic= indic + 1;
            end
        end
    end
    roi_table{ith_roi_path,1} = roi_table_sub;
end
roi_identity = unique(roi_table(:,3));

% roi_table([13,14,15,18],:)=[];
% roi_identity([13,14,15,18],:)=[];
% roi_table=roi_table(6,:);
% roi_identity=roi_identity(6,:);



for ith_roi = 1:length(roi_table(:,1))
    
    curr_roi = roi_identity{ith_roi};
    curr_table = roi_table{ith_roi,1};
    
    export_table = zeros(length(curr_table(:,1)), num_value_col);
    parfor (ith_row = 1:length(curr_table(:,1)))
        
        temp_table = zeros(1,num_value_col);
        
        curr_roi_path = curr_table{ith_row,1};
        sub = curr_table{ith_row,3};
        session = curr_table{ith_row,4};
        curr_info =  curr_table{ith_row,5};
        curr_period= curr_table{ith_row,6};

        mask_struct = MRIread(curr_roi_path);
        mask_brain = mask_struct.vol;
        mask_indexes = find(mask_brain>0);
        output_table = create_volumn_table_each_session_fsl(global_path, sub,session, curr_period);
        
        pre_corr_matrix = nan(length(mask_indexes), length(output_table(:,1)));
        for ith_trial = 1:length(output_table(:,1))
            temp_brain = output_table{ith_trial,1}.vol;
            pre_corr_matrix(:,ith_trial) = temp_brain(mask_indexes);
        end
        pre_corr_matrix(find(pre_corr_matrix(:,1)==0),:)=[];
        [rho,pval] = corr(pre_corr_matrix, 'Type','Pearson');
        t_rho = 0.5 * (log((1+rho)./(1-rho)));

        [biary_matrix] = plot_hard_matrix_fsl_roi_permutation_partial_cells_3periods(output_table, curr_info, curr_period);
        
        temp_table(1) = mean(t_rho(find(biary_matrix==1)));
        temp_table(2) = mean(t_rho(find(biary_matrix==2)));
        
        temp_shuffle_same = NaN(num_shuffle, 1);
        temp_shuffle_diff = NaN(num_shuffle, 1);
        for ith_shuffle = 1:num_shuffle
            shuffled_output_table = output_table(randperm(36),:);
            [biary_matrix] = plot_hard_matrix_fsl_roi_permutation_partial_cells_3periods(shuffled_output_table, curr_info, curr_period);
            temp_shuffle_same(ith_shuffle) = mean(t_rho(find(biary_matrix==1)));
            temp_shuffle_diff(ith_shuffle) = mean(t_rho(find(biary_matrix==2)));
            ['roi:', num2str(ith_roi), ' ith_raw:'  num2str(ith_row)]
        end
        temp_table(3) = mean(temp_shuffle_same);
        temp_table(4) = mean(temp_shuffle_diff);
        export_table(ith_row,:)=temp_table;
    end
    save([global_path, '/analysis_MVPA_permutation/', 'rsa_no_glm_ft_roi_permutation_3periods_partial_', curr_roi, '.mat'], 'export_table');
end




%% save
file_path = '/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA_permutation/';
file_dir = dir(fullfile(file_path, '*permutation_3periods*.mat'));
file_dir = strcat(file_path ,{file_dir.name}');
for ith_file = 1:length(file_dir)
    temp_file = load(file_dir{ith_file});
    temp_file = temp_file.export_table;
    for ith_row = 1:length(temp_file(:,1))
        for ith_col = 1:num_value_col
            roi_table{ith_file,1}{ith_row,ith_col+6} = temp_file(ith_row,ith_col);
        end
    end
end


export_table = cell(length(roi_table(:,1))*19*length(info_list)*3,8);
counter = 1;
for ith_roi = 1:length(roi_table(:,1))
    curr_table = roi_table{ith_roi,1};
    for ith_info = 1:length(info_list)
        for ith_period = 1:length(unique(roi_table{1,1}(:,6)))
            for ith_sub = 8:26
                info_table = curr_table(find(cellfun(@(x,y,z) strcmp(x, info_list{ith_info}) & ...
                    strcmp(y, period_list{ith_period}) & strcmp(z, num2str(ith_sub)), ...
                    curr_table(:,5), curr_table(:,6), curr_table(:,3))),:);
                export_table{counter,1}=info_table{1,2};
                export_table{counter,2}=info_table{1,3};
                export_table{counter,3}=info_table{1,5};
                export_table{counter,4}=info_table{1,6};
                export_table{counter,5}=mean(cell2mat(info_table(:,7)));
                export_table{counter,6}=mean(cell2mat(info_table(:,8)));
                export_table{counter,7}=mean(cell2mat(info_table(:,9)));
                export_table{counter,8}=mean(cell2mat(info_table(:,10)));
                counter = counter+1;
                [num2str(ith_roi), '_', num2str(ith_period), '_', num2str(ith_sub)]
            end
        end
    end
end

fileID = fopen('/Users/boo/Desktop/rsa_no_glm_ft_roi_permutation_3period_partial_cell.txt','w');
for ith_row = 1:length(export_table(:,1))
    fprintf(fileID, '%s\t %s\t %s\t %s\t %1.5f\t %1.5f\t %1.5f\t %1.5f\n',  export_table{ith_row, :});
%     fprintf(fileID, '%s\t %s\t %s\t %s\t %1.5f\t %1.5f\n',  export_table{ith_row, :});
end
fclose(fileID);

















