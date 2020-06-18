function  [biary_matrix] = plot_hard_matrix_fsl_roi_examine_cell_number_in_same_diff(shuffled_output_table, key_for_mvpa)


labelNames = shuffled_output_table(:,7);

count_condition = length(labelNames);
biary_matrix = ones(count_condition,count_condition) * 3;

for col = 1:count_condition
    for row = 1:count_condition
        if(row > col  )

            if (strcmp(key_for_mvpa,  'map'))
                if ( strcmp(shuffled_output_table{col,2}, shuffled_output_table{row,2}) )
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'ed'))
                if ( strcmp(shuffled_output_table{col,3}, shuffled_output_table{row,3}) )
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end

            if (strcmp(key_for_mvpa,  'fcha'))
                if ( strcmp(shuffled_output_table{col,4}, shuffled_output_table{row,4}) )
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'selfo'))
                if (strcmp(shuffled_output_table{col,15}, shuffled_output_table{row,15}))
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end

            if (strcmp(key_for_mvpa,  'tcha'))
                if ( strcmp(shuffled_output_table{col,6}, shuffled_output_table{row,6}))
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'ego'))
                if ( strcmp(shuffled_output_table{col,5}, shuffled_output_table{row,5}) )
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'tcha_location'))
                if (  strcmp(shuffled_output_table{col,16}, shuffled_output_table{row,16}))
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            

        end
    end
end


