function  [b  RHO  ] = plot_hard_matrix_glm_walking(output_table, sub_folder_name, corr_2d_matrix)

count_condition = length( output_table(:,1));
biary_matrix = zeros((count_condition* count_condition- 36)/2 , 3);


inde = 0;
for col = 1:count_condition
    for row = 1:count_condition
        if(row  > col  )
            inde = inde + 1;
            if ( strcmp(output_table{col, 2}, output_table{row, 2}) ) % map
                biary_matrix(inde, 1) = 1;
            end
            if ( strcmp(output_table{col, 3}, output_table{row, 3}) ) % ed
                biary_matrix(inde, 2) = 1;
            end
            biary_matrix(inde, 3) = corr_2d_matrix(col, row);
        end
    end
end



RHO =corr(biary_matrix(:,1:2));
b = glmfit(biary_matrix(:, 1:2),  biary_matrix(:,3));




