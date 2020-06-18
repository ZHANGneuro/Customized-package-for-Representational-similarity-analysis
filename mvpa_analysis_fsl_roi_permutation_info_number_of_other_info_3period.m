

%% reprentation
clear;
global_path ='/Users/boo/Documents/degree_PhD/data_fmri';

final_table = cell(4,2);
period_list = {'w8s_lc_', 'f4s_lc_', 't4s_lc_'};
number_of_fix = 6;
for ith_period = 1:3
    curr_period = period_list{ith_period};
    
    counter =1 ;
    bigger_r_table_same = cell(26,4);
    bigger_r_table_diff = cell(26,4);
    for ith_sub = 8:26
        for ith_sess = 1:4
            
            output_table = create_volumn_table_each_session_fsl(global_path, ith_sub,ith_sess, curr_period);

            r_table_same = cell(number_of_fix,2);
            r_table_diff = cell(number_of_fix,2);
            
            [matrix_pool_same, matrix_pool_diff, label_pool] = plot_hard_matrix_fsl_roi_permutation_for_test(output_table);
            
            for ith_info1 = 1:number_of_fix
                    
                    index_same1_same = find(matrix_pool_same{ith_info1,1}==1);
                    index_same1_diff = find(matrix_pool_same{ith_info1,2}==1);
                    
                    index_diff1_same = find(matrix_pool_diff{ith_info1,1}==1);
                    index_diff1_diff = find(matrix_pool_diff{ith_info1,2}==1);
  
                    mask_struct = MRIread(['/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA_roi/folder_mtl_mpfc/sub',num2str(ith_sub),'_s',num2str(ith_sess),'.nii.gz']);
                    mask_brain = mask_struct.vol;
                    mask_indexes = find(mask_brain>0);
                    pre_corr_matrix = nan(length(mask_indexes), length(output_table(:,1)));
                    for ith_trial = 1:length(output_table(:,1))
                        temp_brain = output_table{ith_trial,1}.vol;
                        pre_corr_matrix(:,ith_trial) = temp_brain(mask_indexes);
                    end
                    pre_corr_matrix(find(pre_corr_matrix(:,1)==0),:)=[];
                    [rho,pval] = corr(pre_corr_matrix, 'Type','Pearson');
                    t_rho = 0.5 * (log((1+rho)./(1-rho)));
                    
                    r_table_same{ith_info1,1}=mean(t_rho(index_same1_same))-mean(t_rho(index_same1_diff));
                    r_table_diff{ith_info1,2}=mean(t_rho(index_diff1_same))-mean(t_rho(index_diff1_diff));
                    [num2str(ith_sub), '_', num2str(ith_sess), '_', num2str(ith_info1), '_']
            end
            bigger_r_table_same{ith_sub, ith_sess} = cell2mat(r_table_same);
            bigger_r_table_diff{ith_sub, ith_sess} = cell2mat(r_table_diff);
        end
    end
    
    new_r_table_same = cell(26,1);
    new_r_table_diff = cell(26,1);
    for ith_row = 8:26
        new_r_table_same{ith_row} = (bigger_r_table_same{ith_row, 1} +bigger_r_table_same{ith_row, 2}+bigger_r_table_same{ith_row, 3}+bigger_r_table_same{ith_row, 4})/4;
        new_r_table_diff{ith_row} = (bigger_r_table_diff{ith_row, 1} +bigger_r_table_diff{ith_row, 2}+bigger_r_table_diff{ith_row, 3}+bigger_r_table_diff{ith_row, 4})/4;
    end
    
    p_table = cell(number_of_fix,1);
    r_table = cell(number_of_fix,1);
    for ith_d1 = 1:number_of_fix
        temp_list_same = [];
        temp_list_diff = [];
        for ith_row = 8:26
            temp_list_same = [temp_list_same; new_r_table_same{ith_row,1}(ith_d1)];
            temp_list_diff = [temp_list_diff; new_r_table_diff{ith_row,1}(ith_d1)];
        end
        [H,P,CI,STATS] = ttest(temp_list_same, temp_list_diff);
        p_table{ith_d1,1} = P;
        r_table{ith_d1,1} = mean(temp_list_same)-mean(temp_list_diff);
    end
    
    final_table{ith_period, 1} = p_table;
    final_table{ith_period, 2} = r_table;
end