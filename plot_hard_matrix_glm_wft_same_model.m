function  b = plot_hard_matrix_glm_wft_same_model(output_table, corr_2d_matrix)

count_condition = length( output_table(:,1));
biary_matrix = zeros(630, 5);

inde = 0;
for col = 1:count_condition
    for row = 1:count_condition
        if row>col
            inde = inde + 1;
            if ( strcmp(output_table{col, 2}, output_table{row, 2}) ) % map
                biary_matrix(inde, 1) = 1;
            end
            if ( strcmp(output_table{col, 3}, output_table{row, 3}) ) % ed
                biary_matrix(inde, 2) = 1;
            end
            if ( strcmp(output_table{col, 15}, output_table{row, 15}) ) % fcha location
                biary_matrix(inde, 3) = 1;
            end
            if strcmp(output_table{col, 5}, output_table{row, 5}) % ego
                biary_matrix(inde, 4) = 1;
            end
            biary_matrix(inde, 5) = corr_2d_matrix(col, row);
        end
    end
end

b = glmfit(biary_matrix(:, 1:4),  biary_matrix(:,5));




