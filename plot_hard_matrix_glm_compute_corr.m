function  [RHO,PVAL] = plot_hard_matrix_glm_compute_corr(output_table, curr_period)

count_condition = length( output_table(:,1));
biary_matrix = zeros(630, 8);

inde = 0;
for col = 1:count_condition
    for row = 1:count_condition
        if row > col
            inde = inde + 1;
            
            if strcmp(curr_period, 'f4s_lc_')
                
                if ( strcmp(output_table{col, 2}, output_table{row, 2}) ) % tmap 1
                    biary_matrix(inde, 1) = 1;
                end
                if ( strcmp(output_table{col, 3}, output_table{row, 3}) ) % walking direction 2
                    biary_matrix(inde, 2) = 1;
                end
                if ( strcmp(output_table{col, 4}, output_table{row, 4})) % fcha_identity 3
                    biary_matrix(inde, 3) = 1;
                end
                if ( strcmp(output_table{col, 15}, output_table{row, 15}) ) % self orientation 5
                    biary_matrix(inde, 4) = 1;
                end
                if strcmp(output_table{col, 8}, output_table{row, 8}) % rotation angle 7
                    biary_matrix(inde, 5) = 1;
                end
                if ( strcmp(output_table{col, 6},'1') & strcmp(output_table{row, 6},'1'))
                    biary_matrix(inde, 6) = 1;
                end
                if ( strcmp(output_table{col, 6},'2') & strcmp(output_table{row, 6},'2'))
                    biary_matrix(inde, 7) = 1;
                end
                if ( strcmp(output_table{col, 6},'3') & strcmp(output_table{row, 6},'3'))
                    biary_matrix(inde, 8) = 1;
                end
                if strcmp(output_table{col, 14}, '11') & strcmp(output_table{row, 14}, '11') % 12 vs
                    biary_matrix(inde, 9) = 1;
                end
                if strcmp(output_table{col, 14}, '12') & strcmp(output_table{row, 14}, '12') % 12 vs
                    biary_matrix(inde, 10) = 1;
                end
                if strcmp(output_table{col, 14}, '13') & strcmp(output_table{row, 14}, '13') % 12 vs
                    biary_matrix(inde, 11) = 1;
                end
                if strcmp(output_table{col, 14}, '14') & strcmp(output_table{row, 14}, '14') % 12 vs
                    biary_matrix(inde, 12) = 1;
                end
                if strcmp(output_table{col, 14}, '21') & strcmp(output_table{row, 14}, '21') % 12 vs
                    biary_matrix(inde, 13) = 1;
                end
                if strcmp(output_table{col, 14}, '22') & strcmp(output_table{row, 14}, '22') % 12 vs
                    biary_matrix(inde, 14) = 1;
                end
                if strcmp(output_table{col, 14}, '23') & strcmp(output_table{row, 14}, '23') % 12 vs
                    biary_matrix(inde, 15) = 1;
                end
                if strcmp(output_table{col, 14}, '24') & strcmp(output_table{row, 14}, '24') % 12 vs
                    biary_matrix(inde, 16) = 1;
                end
                if strcmp(output_table{col, 14}, '31') & strcmp(output_table{row, 14}, '31') % 12 vs
                    biary_matrix(inde, 17) = 1;
                end
                if strcmp(output_table{col, 14}, '32') & strcmp(output_table{row, 14}, '32') % 12 vs
                    biary_matrix(inde, 18) = 1;
                end
                if strcmp(output_table{col, 14}, '33') & strcmp(output_table{row, 14}, '33') % 12 vs
                    biary_matrix(inde, 19) = 1;
                end
                if strcmp(output_table{col, 14}, '34') & strcmp(output_table{row, 14}, '34') % 12 vs
                    biary_matrix(inde, 20) = 1;
                end
                if ( output_table{col, 18}==1 & output_table{row, 18}==1) % button
                    biary_matrix(inde, 21) = 1;
                end
                if ( output_table{col, 18}==2 & output_table{row, 18}==2) % button
                    biary_matrix(inde, 22) = 1;
                end
                if ( output_table{col, 18}==3 & output_table{row, 18}==3) % button
                    biary_matrix(inde, 23) = 1;
                end
            end
            
            if strcmp(curr_period, 't4s_lc_')
                if ( strcmp(output_table{col, 2}, output_table{row, 2}) ) % tmap 1
                    biary_matrix(inde, 1) = 1;
                end
                if ( strcmp(output_table{col, 3}, output_table{row, 3}) ) % walking direction 2
                    biary_matrix(inde, 2) = 1;
                end
                if ( strcmp(output_table{col, 6}, output_table{row, 6})) % tcha_identity 4
                    biary_matrix(inde, 3) = 1;
                end
                if ( strcmp(output_table{col, 15}, output_table{row, 15}) ) % self orientation 5
                    biary_matrix(inde, 4) = 1;
                end
                if strcmp(output_table{col, 5}, output_table{row, 5}) % ego 8
                    biary_matrix(inde, 5) = 1;
                end
                if strcmp(output_table{col, 16}, output_table{row, 16}) %  targeting character allo location 6
                    biary_matrix(inde, 6) = 1;
                end
                if strcmp(output_table{col, 8}, output_table{row, 8}) % rotation angle 7
                    biary_matrix(inde, 7) = 1;
                end
                if ( strcmp(output_table{col, 4},'1') & strcmp(output_table{row, 4},'1'))
                    biary_matrix(inde, 8) = 1;
                end
                if ( strcmp(output_table{col, 4},'2') & strcmp(output_table{row, 4},'2'))
                    biary_matrix(inde, 9) = 1;
                end
                if ( strcmp(output_table{col, 4},'3') & strcmp(output_table{row, 4},'3'))
                    biary_matrix(inde, 10) = 1;
                end
                if strcmp(output_table{col, 14}, '11') & strcmp(output_table{row, 14}, '11') % 12 vs
                    biary_matrix(inde, 11) = 1;
                end
                if strcmp(output_table{col, 14}, '12') & strcmp(output_table{row, 14}, '12') % 12 vs
                    biary_matrix(inde, 12) = 1;
                end
                if strcmp(output_table{col, 14}, '13') & strcmp(output_table{row, 14}, '13') % 12 vs
                    biary_matrix(inde, 13) = 1;
                end
                if strcmp(output_table{col, 14}, '14') & strcmp(output_table{row, 14}, '14') % 12 vs
                    biary_matrix(inde, 14) = 1;
                end
                if strcmp(output_table{col, 14}, '21') & strcmp(output_table{row, 14}, '21') % 12 vs
                    biary_matrix(inde, 15) = 1;
                end
                if strcmp(output_table{col, 14}, '22') & strcmp(output_table{row, 14}, '22') % 12 vs
                    biary_matrix(inde, 16) = 1;
                end
                if strcmp(output_table{col, 14}, '23') & strcmp(output_table{row, 14}, '23') % 12 vs
                    biary_matrix(inde, 17) = 1;
                end
                if strcmp(output_table{col, 14}, '24') & strcmp(output_table{row, 14}, '24') % 12 vs
                    biary_matrix(inde, 18) = 1;
                end
                if strcmp(output_table{col, 14}, '31') & strcmp(output_table{row, 14}, '31') % 12 vs
                    biary_matrix(inde, 19) = 1;
                end
                if strcmp(output_table{col, 14}, '32') & strcmp(output_table{row, 14}, '32') % 12 vs
                    biary_matrix(inde, 20) = 1;
                end
                if strcmp(output_table{col, 14}, '33') & strcmp(output_table{row, 14}, '33') % 12 vs
                    biary_matrix(inde, 21) = 1;
                end
                if strcmp(output_table{col, 14}, '34') & strcmp(output_table{row, 14}, '34') % 12 vs
                    biary_matrix(inde, 22) = 1;
                end
                if ( output_table{col, 18}==1 & output_table{row, 18}==1) % button
                    biary_matrix(inde, 23) = 1;
                end
                if ( output_table{col, 18}==2 & output_table{row, 18}==2) % button
                    biary_matrix(inde, 24) = 1;
                end
                if ( output_table{col, 18}==3 & output_table{row, 18}==3) % button
                    biary_matrix(inde, 25) = 1;
                end
            end
        end
    end
end

if strcmp(curr_period, 'f4s_lc_')
    [RHO,PVAL] =corr(biary_matrix(:,1:23));
end
if strcmp(curr_period, 't4s_lc_')
    [RHO,PVAL] =corr(biary_matrix(:,1:25));
end
