function  [biary_matrix] = plot_hard_matrix_fsl_roi_permutation_for_test(output_table, curr_info)


labelNames = output_table(:,7);

count_condition = length(labelNames);
biary_matrix = ones(count_condition,count_condition) * 3;

for col = 1:count_condition
    for row = 1:count_condition
        if(row > col  )
            
            if (strcmp(curr_info,  'map'))
                if ( strcmp(output_table{col,2}, output_table{row,2}) )
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(curr_info,  'ed'))
                if ( strcmp(output_table{col,3}, output_table{row,3}) )
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(curr_info,  'fcha'))
                if ( strcmp(output_table{col,4}, output_table{row,4}) )
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(curr_info,  'selfo'))
                if (strcmp(output_table{col,15}, output_table{row,15}))
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(curr_info,  'tcha'))
                if ( strcmp(output_table{col,6}, output_table{row,6}))
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(curr_info,  'ego'))
                if ( strcmp(output_table{col,5}, output_table{row,5}) )
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(curr_info,  'tcha_location'))
                if (  strcmp(output_table{col,16}, output_table{row,16}))
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
        end
    end
end