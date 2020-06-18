function  plot_hard_matrix_fsl(output_table, sub_folder_name, corr_2d_matrix);

%% plot r

% labelNames = output_table(:,17);
% count_condition = length(labelNames);
% 
% biary_matrix = corr_2d_matrix;
% 
% plot_path='/Users/boo/Desktop/rrr';
% 
% ax2 = axes('Position',[0.25 0.25 0.75 0.75]);
% ax2.ActivePositionProperty = 'position';
% 
% tickfontsize=8;
% 
% colormap gray;
% imagesc(ax2, biary_matrix);
% 
% h=gca;
% set(h, 'XTick', 1:count_condition);
% set(h, 'YTick', 1:count_condition);
% set(h, 'XTickLabel', labelNames);
% set(h, 'YTickLabel', labelNames);
% set(gca,'FontSize',tickfontsize);
% set(0,'DefaultAxesFontName', 'Arial')
% hold on
% 
% % text(-10, 17, 'i','FontSize',16, 'FontName', 'Arial');
% % text(17, 47, 'j','FontSize',16, 'FontName', 'Arial');
% 
% a=get(h,'XTickLabel');
% set(h,'XTickLabel',[]);
% b=get(h,'XTick');
% text(b,repmat(length(b)+6 ,length(b),1),a,'HorizontalAlignment','left','rotation',90,'FontSize',tickfontsize, 'FontName', 'Arial');
% 
% aa=get(h,'YTickLabel');
% set(h,'YTickLabel',[]);
% bb=get(h,'YTick');
% text(repmat(-5,length(bb),1), bb,aa,'HorizontalAlignment','left','FontSize',tickfontsize, 'FontName', 'Arial');
% 
% curr_figure = gcf;
% set(curr_figure, 'PaperSize', [5 5]); %Set the paper to have width 5 and height 5.
% set(curr_figure,'PaperPosition',[1 1 5 5])
% 
% saveas(gcf, plot_path, 'png'); %Save figure
% 





%% plot variable
labelNames = output_table(:,17);

count_condition = length(labelNames);
biary_matrix = ones(count_condition,count_condition)* 0;

for col = 1:count_condition
    for row = 1:count_condition
        if(row  ~= col  )
            
%             % 'facing fcha'
%             if ( strcmp(output_table{col,4}, output_table{row,4}))
%                 biary_matrix(row, col) = 1;
%             else
%                 biary_matrix(row, col) = 2;
%             end
            
            %'facing fmap'
            if (  strcmp(output_table{col,2}, output_table{row,2})  )
                biary_matrix(row, col) = 1;
            else
                biary_matrix(row, col) = 2;
            end
            
%             %'facing fmap'
%             if (  strcmp(output_table{col,2}, output_table{row,2}) & strcmp(output_table{col,4}, output_table{row,4}) )
%                 biary_matrix(row, col) = 1;
%             elseif ( strcmp(output_table{col,2}, output_table{row,2}) & ~strcmp(output_table{col,4}, output_table{row,4}) )
%                 biary_matrix(row, col) = 2;
%             end
%             

            
%             %'facing fed'
%                         if (strcmp(output_table{col,3}, output_table{row,3}))
%                             biary_matrix(row, col) = 1;
%                         else
%                             biary_matrix(row, col) = 2;
%                         end
            
%             %'facing fcha_location'
%             if (strcmp(output_table{col,15}, output_table{row,15}))
%                 biary_matrix(row, col) = 1;
%             else
%                 biary_matrix(row, col) = 2;
%             end
            
        end
    end
end

[con1_rows, con1_cols] = find(biary_matrix == 1);
[con2_rows, con2_cols] = find(biary_matrix == 2);



% plot_path='/Users/boo/Desktop/example';
% 
% ax2 = axes('Position',[0.25 0.25 0.75 0.75]);
% ax2.ActivePositionProperty = 'position';
% 
% tickfontsize=18;
% keyword={'not used', num2str(length(con1_rows)), num2str(length(con2_rows)) };
% 
% N=length(keyword);
% 
% 
% imagesc(ax2, biary_matrix);
% 
% hold on;
% for i = 1:length(biary_matrix)+1
%    plot([.5,36.5],[i-.5,i-.5],'k-');
%    plot([i-.5,i-.5],[.5,36.5],'k-');
% end
% 
% 
% 
% cmap = [
%     %         [255 255 255]/255; ...  % red
%     %         [255 255 255]/255; ...  % red
%     [1 1 1] ; ...
% 
%     [222  165   39]/255;
%      [7 8 9]/255
%     ];
% colormap(cmap);
% 
% h=gca;
% % set(h, 'XTick', 1:count_condition);
% % set(h, 'YTick', 1:count_condition);
% % set(h, 'XTickLabel', labelNames);
% % set(h, 'YTickLabel', labelNames);
% % set(gca,'FontSize',tickfontsize);
% set(0,'DefaultAxesFontName', 'Arial')
% hold on
% L = line(ones(N),ones(N), 'LineWidth',5);
% set(L,{'color'},mat2cell(cmap,ones(1,N),3));
% % legend(keyword, 'Location','northeast');
% 
% % text(-10, 17, 'i','FontSize',16, 'FontName', 'Arial');
% % text(17, 47, 'j','FontSize',16, 'FontName', 'Arial');
% 
% % a=get(h,'XTickLabel');
% set(h,'XTickLabel',[]);
% % b=get(h,'XTick');
% % text(b,repmat(length(b)+5 ,length(b),1),a,'HorizontalAlignment','left','rotation',90,'FontSize',tickfontsize, 'FontName', 'Arial');
% % 
% % 
% % aa=get(h,'YTickLabel');
% set(h,'YTickLabel',[]);
% % bb=get(h,'YTick');
% % text(repmat(-4,length(bb),1), bb,aa,'HorizontalAlignment','left','FontSize',tickfontsize, 'FontName', 'Arial');
% 
% curr_figure = gcf;
% set(curr_figure, 'PaperSize', [5 5]); %Set the paper to have width 5 and height 5.
% set(curr_figure,'PaperPosition',[1 1 5 5])
% 
% saveas(gcf, plot_path, 'png'); %Save figure




