function  [indexes, indexes_control_all]= plot_hard_matrix_fsl_roi(output_table, key_for_mvpa)


labelNames = output_table(:,7);

count_condition = length(labelNames);
biary_matrix_control_all = ones(count_condition,count_condition) * 3;
biary_matrix = ones(count_condition,count_condition) * 3;
temp_matrix = cell(count_condition,count_condition);

for col = 1:count_condition
    for row = 1:count_condition
        if(row  > col  )
            temp_matrix{col,row} = strcat(num2str(col), '_', num2str(row));
            
   
            if (strcmp(key_for_mvpa,  'facing fmap'))
                if ( strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}))
                    biary_matrix_control_all(row, col) = 1;
                elseif (~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}))
                    biary_matrix_control_all(row, col) = 2;
                end
            end
            if (strcmp(key_for_mvpa,  'targeting tmap'))
                if (strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,5}, output_table{row,5}) & ...
                        ~strcmp(output_table{col,6}, output_table{row,6}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}) & ...
                        ~strcmp(output_table{col,16}, output_table{row,16}))
                    biary_matrix_control_all(row, col) = 1;
                elseif (~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,5}, output_table{row,5}) & ...
                        ~strcmp(output_table{col,6}, output_table{row,6}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}) & ...
                        ~strcmp(output_table{col,16}, output_table{row,16}))
                    biary_matrix_control_all(row, col) = 2;
                end
            end
            
            
            if (strcmp(key_for_mvpa,  'facing fed'))
                if ( ~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}))
                    biary_matrix_control_all(row, col) = 1;
                elseif ( ~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}))
                    biary_matrix_control_all(row, col) = 2;
                end
            end
            if (strcmp(key_for_mvpa,  'targeting ted'))
                if (~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,5}, output_table{row,5}) & ...
                        ~strcmp(output_table{col,6}, output_table{row,6}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}) & ...
                        ~strcmp(output_table{col,16}, output_table{row,16}))
                    biary_matrix_control_all(row, col) = 1;
                elseif (~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,5}, output_table{row,5}) & ...
                        ~strcmp(output_table{col,6}, output_table{row,6}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}) & ...
                        ~strcmp(output_table{col,16}, output_table{row,16}))
                    biary_matrix_control_all(row, col) = 2;
                end
            end
            if (strcmp(key_for_mvpa,  'facing fcha'))
                if ( ~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}))
                    biary_matrix_control_all(row, col) = 1;
                elseif ( ~strcmp(output_table{col,2}, output_table{row,2}) & ...
                         ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}))
                    biary_matrix_control_all(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'targeting tcha'))
                if (~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,5}, output_table{row,5}) & ...
                        strcmp(output_table{col,6}, output_table{row,6}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}) & ...
                        ~strcmp(output_table{col,16}, output_table{row,16}))
                    biary_matrix_control_all(row, col) = 1;
                elseif (~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,5}, output_table{row,5}) & ...
                        ~strcmp(output_table{col,6}, output_table{row,6}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}) & ...
                        ~strcmp(output_table{col,16}, output_table{row,16}))
                    biary_matrix_control_all(row, col) = 2;
                end
            end
            

            if (strcmp(key_for_mvpa,  'targeting ego'))
                if (~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        strcmp(output_table{col,5}, output_table{row,5}) & ...
                        ~strcmp(output_table{col,6}, output_table{row,6}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}) & ...
                        ~strcmp(output_table{col,16}, output_table{row,16}))
                    biary_matrix_control_all(row, col) = 1;
                elseif (~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,5}, output_table{row,5}) & ...
                        ~strcmp(output_table{col,6}, output_table{row,6}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}) & ...
                        ~strcmp(output_table{col,16}, output_table{row,16}))
                    biary_matrix_control_all(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'facing fcha_location'))
                if ( ~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        strcmp(output_table{col,15}, output_table{row,15}))
                    biary_matrix_control_all(row, col) = 1;
                elseif ( ~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}))
                    biary_matrix_control_all(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'targeting tcha_location'))
                if (~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,5}, output_table{row,5}) & ...
                        ~strcmp(output_table{col,6}, output_table{row,6}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}) & ...
                        strcmp(output_table{col,16}, output_table{row,16}))
                    biary_matrix_control_all(row, col) = 1;
                elseif (~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,5}, output_table{row,5}) & ...
                        ~strcmp(output_table{col,6}, output_table{row,6}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}) & ...
                        ~strcmp(output_table{col,16}, output_table{row,16}))
                    biary_matrix_control_all(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'targeting tfcha_location'))
                if (~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,5}, output_table{row,5}) & ...
                        ~strcmp(output_table{col,6}, output_table{row,6}) & ...
                        strcmp(output_table{col,15}, output_table{row,15}) & ...
                        ~strcmp(output_table{col,16}, output_table{row,16}))
                    biary_matrix_control_all(row, col) = 1;
                elseif (~strcmp(output_table{col,2}, output_table{row,2}) & ...
                        ~strcmp(output_table{col,3}, output_table{row,3}) & ...
                        ~strcmp(output_table{col,4}, output_table{row,4}) & ...
                        ~strcmp(output_table{col,5}, output_table{row,5}) & ...
                        ~strcmp(output_table{col,6}, output_table{row,6}) & ...
                        ~strcmp(output_table{col,15}, output_table{row,15}) & ...
                        ~strcmp(output_table{col,16}, output_table{row,16}))
                    biary_matrix_control_all(row, col) = 2;
                end
            end
            
   
            
            
            
            
            if (strcmp(key_for_mvpa,  'facing fmap'))
                if ( strcmp(output_table{col,2}, output_table{row,2}) )
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'facing fed'))
                if ( strcmp(output_table{col,3}, output_table{row,3}) )
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'facing fcha'))
                if ( strcmp(output_table{col,4}, output_table{row,4}) )
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'facing fcha_location'))
                if (strcmp(output_table{col,15}, output_table{row,15}))
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'targeting tmap'))
                if ( strcmp(output_table{col,2}, output_table{row,2}))
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'targeting ted'))
                if ( strcmp(output_table{col,3}, output_table{row,3}))
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'targeting tcha'))
                if ( strcmp(output_table{col,6}, output_table{row,6}))
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'targeting ego'))
                if ( strcmp(output_table{col,5}, output_table{row,5}) )
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            if (strcmp(key_for_mvpa,  'targeting tcha_location'))
                if (  strcmp(output_table{col,16}, output_table{row,16}))
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
            
            
            if (strcmp(key_for_mvpa,  'targeting tfcha_location'))
                if ( strcmp(output_table{col,15}, output_table{row,15}))
                    biary_matrix(row, col) = 1;
                else
                    biary_matrix(row, col) = 2;
                end
            end
        end
    end
end

[con1_rows, con1_cols] = find(biary_matrix == 1);
[con2_rows, con2_cols] = find(biary_matrix == 2);
count_con1 = length(con1_rows);
count_con2 = length(con2_rows);
indexes = [[con1_rows con1_cols ones(count_con1,1) ]  ; [con2_rows con2_cols ones(count_con2,1)*2]];

[con1_rows, con1_cols] = find(biary_matrix_control_all == 1);
[con2_rows, con2_cols] = find(biary_matrix_control_all == 2);
count_con1 = length(con1_rows);
count_con2 = length(con2_rows);
indexes_control_all = [[con1_rows con1_cols ones(count_con1,1) ]  ; [con2_rows con2_cols ones(count_con2,1)*2]];




%
% plot_path='/gpfs/share/home/1401110602/';
%
% if (sub==8 & session == 1& whether_plot)
%     ax2 = axes('Position',[0.25 0.25 0.75 0.75]);
%     ax2.ActivePositionProperty = 'position';
%
%     tickfontsize=8;
%     keyword={ num2str(length(con1_rows)), num2str(length(con2_rows)), 'not used'};
%
%     N=length(keyword);
%     imagesc(ax2, biary_matrix);
%     cmap = [
%         %         [255 255 255]/255; ...  % red
%         %         [255 255 255]/255; ...  % red
%         [255 22 84]/255; ...  % red
%         [240 200  8]/255; ... % yellow
%         [1 1 1]
%         ];
%     colormap(cmap);
%
%     h=gca;
%     set(h, 'XTick', 1:count_condition);
%     set(h, 'YTick', 1:count_condition);
%     set(h, 'XTickLabel', labelNames);
%     set(h, 'YTickLabel', labelNames);
%     set(gca,'FontSize',tickfontsize);
%     set(0,'DefaultAxesFontName', 'Arial')
%     hold on
%     L = line(ones(N),ones(N), 'LineWidth',5);
%     set(L,{'color'},mat2cell(cmap,ones(1,N),3));
%     legend(keyword, 'Location','northeast');
%
%     text(-10, 17, 'i','FontSize',16, 'FontName', 'Arial');
%     text(17, 47, 'j','FontSize',16, 'FontName', 'Arial');
%
%     a=get(h,'XTickLabel');
%     set(h,'XTickLabel',[]);
%     b=get(h,'XTick');
%     text(b,repmat(length(b)+8 ,length(b),1),a,'HorizontalAlignment','left','rotation',90,'FontSize',tickfontsize, 'FontName', 'Arial');
%
%     aa=get(h,'YTickLabel');
%     set(h,'YTickLabel',[]);
%     bb=get(h,'YTick');
%     text(repmat(-7,length(bb),1), bb,aa,'HorizontalAlignment','left','FontSize',tickfontsize, 'FontName', 'Arial');
%
%     curr_figure = gcf;
%     set(curr_figure, 'PaperSize', [5 5]); %Set the paper to have width 5 and height 5.
%     set(curr_figure,'PaperPosition',[1 1 5 5])
%
%     saveas(gcf, [plot_path, key_for_mvpa, '_sub', num2str(sub), '_s', num2str(session)], 'png'); %Save figure
% end



