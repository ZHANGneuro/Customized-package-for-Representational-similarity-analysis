function  [b  RHO  ] = plot_hard_matrix_glm(output_table, sub_folder_name, corr_2d_matrix)

count_condition = length( output_table(:,1));
if strcmp(sub_folder_name, 'f4s_lc_')
    biary_matrix = zeros(count_condition*count_condition, 6);
elseif strcmp(sub_folder_name, 't4s_lc_')
    biary_matrix = zeros(count_condition*count_condition, 8);
end

inde = 0;
for col = 1:count_condition
    for row = 1:count_condition
        inde = inde + 1;
        if strcmp(sub_folder_name, 'f4s_lc_')
            if ( strcmp(output_table{col, 2}, output_table{row, 2}) ) % map
                biary_matrix(inde, 1) = 1;
            end
            if ( strcmp(output_table{col, 3}, output_table{row, 3}) ) % ed
                biary_matrix(inde, 2) = 1;
            end
            if ( strcmp(output_table{col, 4}, output_table{row, 4}) ) % fcha
                biary_matrix(inde, 3) = 1;
            end
            if ( strcmp(output_table{col, 8}, output_table{row, 8}) ) % angle
                biary_matrix(inde, 4) = 1;
            end
            if ( strcmp(output_table{col, 15}, output_table{row, 15}) ) % orientation relative to map
                biary_matrix(inde, 5) = 1;
            end
            biary_matrix(inde, 6) = corr_2d_matrix(col, row);
            
        elseif strcmp(sub_folder_name, 't4s_lc_')
            if ( strcmp(output_table{col, 2}, output_table{row, 2}) ) % tmap
                biary_matrix(inde, 1) = 1;
            end
            if ( strcmp(output_table{col, 3}, output_table{row, 3}) ) % ted
                biary_matrix(inde, 2) = 1;
            end
            if ( strcmp(output_table{col, 6}, output_table{row, 6})) % tdo
                biary_matrix(inde, 3) = 1;
            end
            if ( strcmp(output_table{col, 15}, output_table{row, 15}) ) % fcha location
                biary_matrix(inde, 4) = 1;
            end
            if strcmp(output_table{col, 16}, output_table{row, 16}) %  tcha location
                biary_matrix(inde, 5) = 1;
            end
            if strcmp(output_table{col, 8}, output_table{row, 8}) % angle
                biary_matrix(inde, 6) = 1;
            end
            if strcmp(output_table{col, 5}, output_table{row, 5}) % ego
                biary_matrix(inde, 7) = 1;
            end
%             if strcmp(output_table{col, 5}, 'left' ) & strcmp(output_table{row, 5}, 'left' ) % ego l
%                 biary_matrix(inde, 7) = 1;
%             end
%             if strcmp(output_table{col, 5}, 'right' ) & strcmp(output_table{row, 5}, 'right' ) % ego r
%                 biary_matrix(inde, 8) = 1;
%             end
%             if strcmp(output_table{col, 5}, 'back' ) & strcmp(output_table{row, 5}, 'back' ) % ego b
%                 biary_matrix(inde, 9) = 1;
%             end
            biary_matrix(inde, 8) = corr_2d_matrix(col, row);
        end
    end
end


if strcmp(sub_folder_name, 'f4s_lc_')
    biary_matrix( find(biary_matrix(:,6)==inf),:)=[];  % 1 fmap  2 fed   3 fcha  4 angle
    RHO =corr(biary_matrix(:,1:5));
    b = glmfit(biary_matrix(:, 1:5),  biary_matrix(:,6));
    
elseif strcmp(sub_folder_name, 't4s_lc_')
    
    biary_matrix( find(biary_matrix(:,8)==inf),:)=[];  % 1 fmap  2 fed   3 fcha  4 angle
    RHO =corr(biary_matrix(:,1:7));
    b = glmfit(biary_matrix(:, 1:7),  biary_matrix(:,8));
    
end





