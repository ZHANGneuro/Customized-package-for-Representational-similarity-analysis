

%% 
data = 1:100;
imagesc(data);
% xticks = linspace(1, size(value_list, 2), numel(xticklabels));
xticks = [10, 25, 40, 60, 75, 90];
set(gca, 'YTick', [], 'YTickLabel', []);
set(gca,'XDir','normal');
colorbar = colormap(jet(length(data)));

colorbar(40:60,:) = 1;
xticklabels = [0.99, 0.95, 0.90, 0.90, 0.95, 0.99];

colormap(colorbar);
set(gcf,'Position',[100 100 500 90])
set(gca,'XTick', xticks, 'XTickLabel',xticklabels,'FontName','Helvetica','fontsize',35)





%%
data = 1:100;
imagesc(data);
% xticks = linspace(1, size(value_list, 2), numel(xticklabels));
xticks = [10, 90];
set(gca, 'YTick', [], 'YTickLabel', []);
set(gca,'XDir','normal');
colorbar = colormap(jet(length(data)));

% colorbar(40:60,:) = 1;
colorbar = colorbar(62:100,:);
xticklabels = [0.95, 0.99];

colormap(colorbar);
set(gcf,'Position',[100 100 500 90])
set(gca,'XTick', xticks, 'XTickLabel',xticklabels,'FontName','Helvetica','fontsize',37)







grad_blue=colorGradient([0/255,0/255,255/255],[0/255,255/255,255/255],100);
value_list = [-10:0.1:0];
imagesc(flipud(value_list'));
axis off;
set(gca, 'XTick', [], 'XTickLabel', []);
set(gca,'YDir','normal');
colorbar = grad_blue; 
colormap(flipud(colorbar(20:100,:)));
set(gcf,'Position',[0 0 20 200]);


grad_red=colorGradient([1 0 0],[1 1 0.2],100);
value_list = [0:0.1:10];
imagesc(flipud(value_list'));
axis off;
set(gca, 'XTick', [], 'XTickLabel', []);
set(gca,'YDir','normal');
colorbar = grad_red; 
colormap(flipud(colorbar(20:100,:)));
set(gcf,'Position',[100 100 20 200]);


%% 
value_list = readNPY('/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_period/hnd_statistic_ima/tvalue_cropped_2.5_raw_targeting_nowr.nii');
value_list = value_list(:);

value_list = sort(value_list);
value_list = round(value_list,2);

num_ele090 = round(length(value_list)*0.1/2);
num_ele095 = round(length(value_list)*0.05/2);
num_ele099 = round(length(value_list)*0.01/2);

tail090_1 = value_list(1:num_ele090);
tail090_2 = value_list(length(value_list)-num_ele090+1:end);

tail095_1 = value_list(1:num_ele095);
tail095_2 = value_list(length(value_list)-num_ele095+1:end);

tail099_1 = value_list(1:num_ele099);
tail099_2 = value_list(length(value_list)-num_ele099+1:end);


% value_list = [min(value_list):0.01:max(value_list)];
value_list = value_list';
imagesc(value_list);

xticklabels = [max(tail099_1), max(tail095_1), min(tail095_2), min(tail099_2)];

xticks = linspace(1, size(value_list, 2), numel(xticklabels));
set(gca, 'YTick', [], 'YTickLabel', []);
set(gca,'XDir','normal');
colorbar = colormap(jet(length(value_list)));

index = find(value_list>max(tail099_1) & value_list<min(tail099_2));
colorbar(index,:) = 1;
value_list(index,:) = 0;

colormap(colorbar);
set(gcf,'Position',[100 100 500 90])
set(gca,'XTick', xticks, 'XTickLabel',xticklabels,'FontName','Helvetica','fontsize',35)











%% horizational 
input_path = '/Users/boo/Desktop/MEG_data_script/result_MRI_ego_figure/b_lr_svc_corrected.nii';
h1 = MRIread(input_path);
value_list = h1.vol;
value_list = value_list(:);
value_list = unique(value_list);

value_list = [6:2:12];
imagesc(value_list);
xticklabels = [6:2:12];
xticks = linspace(1, size(value_list, 2), numel(xticklabels));
set(gca, 'YTick', [], 'YTickLabel', []);
set(gca,'XDir','normal');
colorbar = colormap(hot(64));
colormap(colorbar(30:50,:));
set(gcf,'Position',[100 100 500 90])
set(gca,'XTick', xticks, 'XTickLabel',xticklabels,'FontName','Helvetica','fontsize',35)



%% vertical 
input_path = '/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_period/hnd_statistic_ima/wr_3.6_hnd_data_targeting-facing_tval.nii';
h1 = MRIread(input_path);
value_list = h1.vol;
value_list(find(value_list==0))=[];
min(value_list)
max(value_list)

value_list = [4:0.1:13];
imagesc(flipud(value_list'));
yticklabels = [4:2:13]';
yticks = linspace(1, size(value_list, 2), numel(yticklabels));
set(gca, 'XTick', [], 'XTickLabel', []);
set(gca,'YDir','normal');
colorbar = colormap(hot(64));
colormap(flipud(colorbar(25:50,:)));
set(gcf,'Position',[100 100 90 650]);
set(gca,'YTick', yticks, 'YTickLabel',yticklabels,'FontName','Helvetica','fontsize',40)


% value_list = [3:0.1:16];
% imagesc(flipud(value_list'));
% yticklabels = [3:3:16]';


%% vertical 
input_path = '/Users/boo/Desktop/MEG_data_script/result_MRI_ego_figure/tval_ego_right_back.nii';
h1 = MRIread(input_path);
value_list = h1.vol;
value_list(find(value_list==0))=[];
[min(value_list(:)), max(value_list(:))]


input_path = '/Users/boo/Desktop/MEG_data_script/result_MRI_ego_figure/tval_ego_left_back.nii';
h1 = MRIread(input_path);
value_list = h1.vol;
value_list(find(value_list==0))=[];
[min(value_list(:)), max(value_list(:))]


input_path = '/Users/boo/Desktop/MEG_data_script/result_MRI_ego_figure/tval_raw_ego_back.nii';
h1 = MRIread(input_path);
value_list = h1.vol;
value_list(find(value_list==0))=[];
[min(value_list(:)), max(value_list(:))]




