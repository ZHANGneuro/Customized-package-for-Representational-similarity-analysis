function  [b  RHO  ] = plot_hard_matrix_glm_noise(output_table, corr_2d_matrix)

count_condition = length( output_table(:,1));
biary_matrix = zeros((count_condition* count_condition- 36)/2 , 5);


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
            if ( strcmp(output_table{col, 4}, output_table{row, 4})) % ffdo
                biary_matrix(inde, 3) = 1;
            end
            if ( strcmp(output_table{col, 6}, output_table{row, 6}) ) % ftdo
                biary_matrix(inde, 4) = 1;
            end
%             if strcmp(output_table{col, 15}, output_table{row, 15}) %  ffdo_location
%                 biary_matrix(inde, 5) = 1;
%             end
%             if strcmp(output_table{col, 16}, output_table{row, 16}) % ftdo_location
%                 biary_matrix(inde, 6) = 1;
%             end
%             if strcmp(output_table{col, 5}, output_table{row, 5}) % ego
%                 biary_matrix(inde, 3) = 1;
%             end
%             if strcmp(output_table{col, 8}, output_table{row, 8}) % fangle
%                 biary_matrix(inde, 8) = 1;
%             end
            biary_matrix(inde, 5) = corr_2d_matrix(col, row);
        end
    end
end



RHO =corr(biary_matrix(:,1:4));
b = glmfit(biary_matrix(:, 1:4),  biary_matrix(:,5));




