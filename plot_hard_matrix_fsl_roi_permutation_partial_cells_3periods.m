function  [biary_matrix] = plot_hard_matrix_fsl_roi_permutation_partial_cells(output_table, curr_info, curr_period)


labelNames = output_table(:,7);

count_condition = length(labelNames);
biary_matrix = ones(count_condition,count_condition) * 3;

for col = 1:count_condition
    for row = 1:count_condition
        if(row > col  )
            
            
            if strcmp(curr_period, 'w8s_lc_') | strcmp(curr_period, 'f4s_lc_')
                if (strcmp(curr_info,  'map'))
                    if strcmp(output_table{col,2}, output_table{row,2})
                        biary_matrix(row, col) = 1;
                    else
                        biary_matrix(row, col) = 2;
                    end
                end
                if (strcmp(curr_info,  'selfo'))
                    if (strcmp(output_table{col,15}, output_table{row,15}) & ...
                            ~strcmp(output_table{col,5}, output_table{row,5}))
                        biary_matrix(row, col) = 1;
                    elseif (~strcmp(output_table{col,15}, output_table{row,15}) & ...
                            ~strcmp(output_table{col,5}, output_table{row,5}))
                        biary_matrix(row, col) = 2;
                    end
                end
                
                if (strcmp(curr_info,  'ego'))
                    if (~strcmp(output_table{col,15}, output_table{row,15}) & ...
                            strcmp(output_table{col,5}, output_table{row,5}))
                        biary_matrix(row, col) = 1;
                    elseif (~strcmp(output_table{col,15}, output_table{row,15}) & ...
                            ~strcmp(output_table{col,5}, output_table{row,5}))
                        biary_matrix(row, col) = 2;
                    end
                end
            end
            
            if strcmp(curr_period, 't4s_lc_')
                if strcmp(curr_info,  'map')
                    if strcmp(output_table{col,2}, output_table{row,2})
                        biary_matrix(row, col) = 1;
                    else
                        biary_matrix(row, col) = 2;
                    end
                end
                if strcmp(curr_info,  'selfo')
                    if strcmp(output_table{col,15}, output_table{row,15})
                        biary_matrix(row, col) = 1;
                    else
                        biary_matrix(row, col) = 2;
                    end
                end
                
                if (strcmp(curr_info,  'ego'))
                    if (strcmp(output_table{col,5}, output_table{row,5}))
                        biary_matrix(row, col) = 1;
                    else
                        biary_matrix(row, col) = 2;
                    end
                end
                
            end
        end
    end
end




