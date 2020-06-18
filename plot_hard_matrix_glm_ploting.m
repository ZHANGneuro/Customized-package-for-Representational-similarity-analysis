function  [b  RHO  ] = plot_hard_matrix_glm_ploting(output_table, sub_folder_name, corr_2d_matrix)

count_condition = length( output_table(:,1));
if strcmp(sub_folder_name, 'f4s_lc_')
    biary_matrix = zeros(count_condition*count_condition, 6);
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

        end
    end
end


[con1_rows, con1_cols] = find(biary_matrix == 1);
[con2_rows, con2_cols] = find(biary_matrix == 0);
count_con1 = length(con1_rows);
count_con2 = length(con2_rows);
indexes = [[con1_rows con1_cols ones(count_con1,1) ]  ; [con2_rows con2_cols ones(count_con2,1)*2]];


plot_path='/Users/boo/Desktop/';
if (sub==8 & session == 1& whether_plot)
    
    ax2 = axes('Position',[0.25 0.25 0.75 0.75]);
    ax2.ActivePositionProperty = 'position';
    
    tickfontsize=8;
    keyword={ num2str(length(con1_rows)), num2str(length(con2_rows)), 'not used'};
    
    N=length(keyword);
    imagesc(ax2, biary_matrix);
    cmap = [
        %         [255 255 255]/255; ...  % red
        %         [255 255 255]/255; ...  % red
        [255 22 84]/255; ...  % red
        [240 200  8]/255; ... % yellow
        [1 1 1]
        ];
    colormap(cmap);
    
    h=gca;
    set(h, 'XTick', 1:count_condition);
    set(h, 'YTick', 1:count_condition);
    set(h, 'XTickLabel', labelNames);
    set(h, 'YTickLabel', labelNames);
    set(gca,'FontSize',tickfontsize);
    set(0,'DefaultAxesFontName', 'Arial')
    hold on
    L = line(ones(N),ones(N), 'LineWidth',5);
    set(L,{'color'},mat2cell(cmap,ones(1,N),3));
    legend(keyword, 'Location','northeast');
    
    text(-10, 17, 'i','FontSize',16, 'FontName', 'Arial');
    text(17, 47, 'j','FontSize',16, 'FontName', 'Arial');
    
    a=get(h,'XTickLabel');
    set(h,'XTickLabel',[]);
    b=get(h,'XTick');
    text(b,repmat(length(b)+9 ,length(b),1),a,'HorizontalAlignment','left','rotation',90,'FontSize',tickfontsize, 'FontName', 'Arial');

    aa=get(h,'YTickLabel');
    set(h,'YTickLabel',[]);
    bb=get(h,'YTick');
    text(repmat(-8,length(bb),1), bb,aa,'HorizontalAlignment','left','FontSize',tickfontsize, 'FontName', 'Arial');
    
    curr_figure = gcf;
    set(curr_figure, 'PaperSize', [5 5]); %Set the paper to have width 5 and height 5.
    set(curr_figure,'PaperPosition',[1 1 5 5])
    saveas(curr_figure, [plot_path, key_for_mvpa, '_sub1', num2str(sub), '_s', num2str(session)], 'png'); %Save figure
    close(curr_figure);
end



