

%% get basic table
clear;

target_path ='/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/';

roi_folder_path= [target_path, ''];
brain_dir = dir(fullfile(target_path, 'fsl_glm_wft4_*_averaged'));
brain_dir = strcat(target_path,{brain_dir.name}');

brain_dir([7:12, 13],:) = [];

export_table = cell(length(brain_dir)*19, 4);
counter = 1;
for ith = 1:length(brain_dir)
    
    curr_path = brain_dir{ith};
    curr_dir = dir(fullfile(curr_path, 'mean_mni_*_fsl152*'));
    curr_dir = strcat(curr_path, '/' ,{curr_dir.name}');
    
    for ith_file = 1:length(curr_dir)
        curr_file = curr_dir{ith_file};
        
        temp_str = extractBetween(curr_file, 'fsl_glm_wft4_', '_averaged');
        temp_list = strsplit(temp_str{1}, '_');
        curr_period = temp_list{1};
        curr_info = temp_list{2};
        curr_sub = extractBetween(curr_file, 'mean_mni_sub', '_fsl152.nii');
        curr_sub = curr_sub{1};
        ima_struct = MRIread(curr_file);
        ima = ima_struct.vol;
        ima(find(ima==0))=[];
        curr_mean = mean(ima);
        
        export_table{counter,1} = curr_period;
        export_table{counter,2} = curr_info;
        export_table{counter,3} = curr_sub;
        export_table{counter,4} = curr_mean;
        
        counter = counter+1;
    end
end


mean(cell2mat(export_table(find(cellfun(@(x,y) strcmp(x, 'selfo') & strcmp(y, 'w8s'), export_table(:,2), export_table(:,1))),4)))
mean(cell2mat(export_table(find(cellfun(@(x,y) strcmp(x, 'selfo') & strcmp(y, 'f4s'), export_table(:,2), export_table(:,1))),4)))
mean(cell2mat(export_table(find(cellfun(@(x,y) strcmp(x, 'selfo') & strcmp(y, 't4s'), export_table(:,2), export_table(:,1))),4)))



fileID = fopen('/Users/boo/Desktop/rsa_each_info_whole_brain_mean_3period.txt','w');
for ith_row = 1:length(export_table(:,1))
    fprintf(fileID, '%s\t %s\t %s\t %1.5f\n',  export_table{ith_row, :});
end
fclose(fileID);

















