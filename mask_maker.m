

%% mask outside brain

brain_mask_struct = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/brainmask/fsl\ standard/MNI152_T1_1mm.nii.gz');
brain_mask_ima = brain_mask_struct.vol;
% brain_mask_ima(find(brain_mask_ima==0))=2;
% brain_mask_ima(find(brain_mask_ima==1))=0;
% brain_mask_ima(find(brain_mask_ima==2))=1;
brain_mask_ima(find(brain_mask_ima>800))=0;
brain_mask_ima(find(brain_mask_ima>0))=1;
brain_mask_struct.vol = brain_mask_ima;
MRIwrite(brain_mask_struct, '/Users/boo/Desktop/mask_outside_brain.nii');


%% separate area into l and r
target_folder_path = '/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA_roi/';
brain_dir = dir(fullfile(target_folder_path, 'both*'));
brain_dir = strcat(target_folder_path,   {brain_dir.name}');

for ith = 1:length(brain_dir)
    
    curr_path = brain_dir{ith};
    curr_file_list = dir(fullfile(curr_path, 'sub*'));
    curr_file_list = strcat(curr_path,  '/', {curr_file_list.name}');
    for ith_file = 1:length(curr_file_list)
        
        curr_file = curr_file_list{ith_file};
        
        file_name_end = strsplit(curr_file, '/sub');
        file_name_end = file_name_end{2};
        
        ima_strct = MRIread(curr_file);
        ima = ima_strct.vol;
        temp_l = ima;
        temp_r = ima;
        temp_l(:,1:56,:) = 0;
        temp_r(:,57:110,:) = 0;
        
        file_identity = extractBetween(curr_file, 'both_','/sub');
        file_identity = file_identity{1};
        
        export_path_l = ['/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA_roi/', file_identity, '_l'];
        if ~exist(export_path_l, 'dir')
            mkdir(export_path_l)
        end
        ima_strct.vol = temp_l;
        MRIwrite(ima_strct, [export_path_l, '/sub', file_name_end]);
        
        export_path_r = ['/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA_roi/', file_identity, '_r'];
        if ~exist(export_path_r, 'dir')
            mkdir(export_path_r)
        end
        ima_strct.vol = temp_r;
        MRIwrite(ima_strct, [export_path_r, '/sub', file_name_end]);
    end
end




%%separate a image as l and r
target_folder_path = '/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_period/mask_HPCa_aal.nii';
ima_strct = MRIread(target_folder_path);
ima = ima_strct.vol;
ima(find(ima>0))=1;
temp_l = ima;
temp_r = ima;
temp_l(:,1:45,:) = 0;
temp_r(:,45:90,:) = 0;
ima_strct.vol = temp_l;
MRIwrite(ima_strct, '/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_period/mask_HPCa_aal_l.nii');
ima_strct.vol = temp_r;
MRIwrite(ima_strct, '/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_period/mask_HPCa_aal_r.nii');


%% change value
curr_path = '/Users/boo/Desktop/mt1_mprage_sag_iso_mww.nii';
curr_stru = MRIread(curr_path);
curr_vol = curr_stru.vol;
curr_vol(find(curr_vol<180)) = NaN;
curr_stru.vol = curr_vol;
MRIwrite(curr_stru, '/Users/boo/Desktop/t1_sub11.nii');



%% change value to 1 for freesurfer FC
target_folder_path = '/Users/boo/Documents/degree_PhD/data_fmri/manuscript_figure/ai_fig_for_illustartion_fig/';
brain_dir = dir(fullfile(target_folder_path, 'pe*.gz'));
brain_dir = strcat(target_folder_path,   {brain_dir.name}');

for ith = 1:length(brain_dir)
    
    curr_file = brain_dir{ith};
    file_name_end = strsplit(curr_file, '/ai_fig_for_illustartion_fig/');
    file_name_end = file_name_end{2};
    
    ima_strct = MRIread(curr_file);
    ima = ima_strct.vol;
    
    %     unique(ima)
    ima(find(ima==0)) = NaN;
    
    ima_strct.vol = ima;
    MRIwrite(ima_strct, [target_folder_path, file_name_end]);
end



%% get number of volumn for each session
curr_path = '/Users/boo/Documents/degree_PhD/data_fmri/residual_fc_5mm_derivative_bandpass/';
final_matrix = NaN(26,4);
for ith_sub = 8:26
    for ith_sess = 1:4
        curr_stru = MRIread([curr_path, 'bandpass_sub', num2str(ith_sub), '_s',num2str(ith_sess), '.nii']);
        temp_size = size(curr_stru.vol);
        final_matrix(ith_sub, ith_sess) = temp_size(4);
    end
end
final_matrix2 = final_matrix(8:26,:);
mean(final_matrix2,1)


%%
mask_stru = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/brainmask/mask_nowmnosubc_original.nii');
mask_ima = mask_stru.vol;

hpc_path = '/Users/boo/Documents/degree_PhD/data_fmri/brainmask/mask_HPC_aal.nii';
hpc_stru = MRIread(hpc_path);
hpc_ima = hpc_stru.vol;
hpc_ima(find(hpc_ima>0))=1;

new_ima = mask_ima+hpc_ima;
new_ima(find(new_ima>0))=1;

hpc_stru.vol = new_ima;
MRIwrite(hpc_stru, '/Users/boo/Desktop/mask_nowmnosubc_original_normal_hpc.nii');



%% remove white matter in given folder
target_folder_path= '/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_period/hnd_statistic_ima/';
brain_dir = dir(fullfile(target_folder_path, 'tvalue_cropped_2.5_raw*'));
brain_dir = strcat(target_folder_path,   {brain_dir.name}');
mni152_strct = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/brainmask/mask_nowmnosubc_original_normal_hpc.nii'); %mask_nowmnosubc_original  mask_nowm
mni152_ima = mni152_strct.vol;
ith_pool = find(mni152_ima~=0);
for n = 1:length(brain_dir)
    file_name= extractBetween(brain_dir{n}, 'hnd_statistic_ima/', '.nii');
    file_name = file_name{1};
    empty_brain = mni152_ima;
    empty_brain(:,:,:)=NaN;
    sub_brain = MRIread(brain_dir{n});
    sub_ima = sub_brain.vol;
    empty_brain(ith_pool) = sub_ima (ith_pool);
    sub_brain.vol = empty_brain;
    MRIwrite(sub_brain, [target_folder_path ,file_name, '_wr' ,'.nii']);
end



%% extract region from atlas
folder_path= '/Users/boo/Desktop/fmri_script/analysis_MVPA/filtered_201907chaslocation361/';
brain_dir = dir(fullfile(folder_path, 'wr_*'));
brain_dir = strcat(folder_path,   {brain_dir.name}');

for ith = 1:length(brain_dir)
    curr_path = brain_dir{ith};
    temp = strsplit(curr_path, 'filtered_201907chaslocation361/');
    temp = temp{2};
    
    curr_stru = MRIread(curr_path);
    curr_vol = curr_stru.vol;
    
    curr_vol(find(curr_vol<0.95)) = 0;
    curr_vol(find(curr_vol>0)) = 1;
    curr_stru.vol = curr_vol;
    MRIwrite(curr_stru, [folder_path, 'wr_1_' ,temp]);
end





%% change voxel size
voxsiz = [1 1 1]; % new voxel size {mm}
V = spm_select([1 Inf],'image');
V = spm_vol(V);
for i=1:numel(V)
    bb        = spm_get_bbox(V(i));
    VV(1:2)   = V(i);
    VV(1).mat = spm_matrix([bb(1,:) 0 0 0 voxsiz])*spm_matrix([-1 -1 -1]);
    VV(1).dim = ceil(VV(1).mat \ [bb(2,:) 1]' - 0.1)';
    VV(1).dim = VV(1).dim(1:3);
    spm_reslice(VV,struct('mean',false,'which',1,'interp',0)); % 1 for linear
end



%%
clc;
spm('defaults','fmri');
spm_jobman('initcfg');
matlabbatch=[];
matlabbatch{1}.spm.spatial.coreg.write.ref = {'/Users/boo/Desktop/fmri_script/brainmask/original_ima/MNI152_T1_1mm.nii'};
matlabbatch{1}.spm.spatial.coreg.write.source = {'/Users/boo/Desktop/sVSVD01-0003-00001-000192-01.nii'};
matlabbatch{1}.spm.spatial.coreg.write.roptions.interp = 4;
matlabbatch{1}.spm.spatial.coreg.write.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.coreg.write.roptions.mask = 0;
matlabbatch{1}.spm.spatial.coreg.write.roptions.prefix = '1mm_';
spm_jobman('run',matlabbatch);





%% remove cluster <0.95
target_folder_path= '/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_period/hnd_statistic_ima/';
brain_dir = dir(fullfile(target_folder_path, 'wr_3.6*corrp*'));
brain_dir = strcat(target_folder_path,   {brain_dir.name}');
for n = 1:length(brain_dir)
    file_name= extractBetween(brain_dir{n}, 'hnd_statistic_ima/', '.nii');
    file_name = file_name{1};
    sub_brain = MRIread(brain_dir{n});
    sub_ima = sub_brain.vol;
    sub_ima(find(sub_ima<0.95))=0;
    sub_brain.vol = sub_ima;
    MRIwrite(sub_brain, [target_folder_path, file_name ,'.nii']);
end


%% remove less than
path = '/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_period/hnd_statistic_ima/';
brain_dir = dir(fullfile(path, '*wr.nii'));
brain_dir = strcat(path,  {brain_dir.name}');
C=6;
for n = 1:length(brain_dir)
    imas = MRIread(brain_dir{n});
    ima = imas.vol;
    final_ima = NaNs(size(ima));
    nvox = length(ima(:));
    cc = arrayfun(@(x) bwconncomp(bsxfun(@gt,ima,x),C), 0);
    ima_1d = NaNs(nvox,1);
    array_for_numVoxel_eachCluster = cellfun(@numel,cc.PixelIdxList);
    for each_cluster = 1:cc.NumObjects
        if array_for_numVoxel_eachCluster(each_cluster)>10
            indexes = cc.PixelIdxList{each_cluster};
            ima_1d(cc.PixelIdxList{each_cluster}) = ima(indexes);
        end
    end
    final_ima(:)=ima_1d;
    imas.vol = final_ima;
    MRIwrite(imas,brain_dir{n});
end



%% replace cluster with t value
path = '/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/manuscript2_result/';
brain_dir = dir(fullfile(path, '*corrp*'));
brain_dir = strcat(path,  {brain_dir.name}');
C=6;
for n = 1:length(brain_dir)
    temp_name = extractBetween(brain_dir{n}, 'manuscript2_result/', '_clustere_corrp');
    temp_name = temp_name{1};
    
    path_t = path;
    brain_dir_t = dir(fullfile(path_t, ['*' , temp_name,'_tstat1.nii*']));
    brain_dir_t = strcat(path_t,  {brain_dir_t.name}');
    imas_t = MRIread(brain_dir_t{1});
    ima_t = imas_t.vol;
    
    imas = MRIread(brain_dir{n});
    ima = imas.vol;
    ima(find(ima<0.95))=0;
    final_ima = zeros(size(ima));
    nvox = length(ima(:));
    cc = arrayfun(@(x) bwconncomp(bsxfun(@gt,ima,x),C), 0);
    ima_1d = zeros(nvox,1);
    array_for_numVoxel_eachCluster = cellfun(@numel,cc.PixelIdxList);
    for each_cluster = 1:cc.NumObjects
        indexes = cc.PixelIdxList{each_cluster};
        ima_1d(cc.PixelIdxList{each_cluster}) = ima_t(indexes);
    end
    final_ima(:)=ima_1d;
    imas.vol = final_ima;
    MRIwrite(imas,[path, '/tval_',temp_name,'.nii']);
end






%% combine any regions
h1 = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/brainmask/aal/aal_51/Frontal_Sup_Medial.nii');
h2 = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/brainmask/aal/aal_51/Frontal_Med_Orb.nii');
h3 = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/brainmask/aal/aal_51/Rectus.nii');
h4 = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/brainmask/aal/aal_51/OFCmed.nii');

mask_ima1 = h1.vol;
mask_ima2 = h2.vol;
mask_ima3 = h3.vol;
mask_ima4 = h4.vol;

temp_ima = mask_ima1+mask_ima2+mask_ima3+mask_ima4;
h1.vol = temp_ima;
MRIwrite(h1,'/Users/boo/Desktop/mask_mPFC.nii');




%% export region from AAL
h9_struct = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/brainmask/aal/aal2.nii');
h9 = h9_struct.vol;
h9(find(h9<41 | h9>42)) = 0;
h9_struct.vol = h9;
MRIwrite(h9_struct,'/Users/boo/Documents/degree_PhD/data_fmri/brainmask/mask_HPC_aal.nii');

path_lc = fopen('/Users/boo/Desktop/brainmask/aal/c_aal2.txt','rt');
table_lc = textscan(path_lc,'%s %s');
atlas_struct = MRIread('/Users/boo/Desktop/brainmask/aal/c_aal2.nii');
atlas = atlas_struct.vol;
for m = 1:length(table_lc{1,1})
    region_ith = str2double(table_lc{1,1}{m,1});
    region_name = table_lc{1,2}{m,1};
    temp_ima = atlas;
    temp_ima(:) = 0;
    temp_ima(find(atlas==region_ith)) = 1;
    atlas_struct.vol = temp_ima;
    MRIwrite(atlas_struct,['/Users/boo/Desktop/brainmask/aal/aal_each/', region_name, '.nii']);
end



%% extract region from atlas
pimage = MRIread('/Users/boo/Desktop/fmri_script/analysis_FC_peak_seed/seed a_cingulate ba10 vmpfc rectus/rois/seed_tmap.nii');
pimagevol = pimage.vol;
size(pimagevol)

% pimagevol(find(~ismember( pimagevol,  [71 72] ))) = 0;
% pimagevol(find(pimagevol>0)) = 1;
pimagevol(1:61, :, :) = 0;

% pimagevol(find(pimagevol<555)) = 0;
pimage.vol = pimagevol;
MRIwrite(pimage,'/Users/boo/Desktop/fmri_script/analysis_FC_peak_seed/seed a_cingulate ba10 vmpfc rectus/rois/seed_tmap.nii');




%% make spheric ROI
roi_path = '/Users/boo/Desktop/fmri_script/ppi_analysis/rois/pfc_roi.nii';
uncorr_ima_path = '/Users/boo/Desktop/fmri_script/analysis_mvpa/fsl_glm_mdte_t4s_lc_tmap_averaged_uncorrp.nii';
spherec_coordinate = sphericalRelativeRoi(6,[2 2 2]);

roi_struct = MRIread(roi_path);
uncorr_ima_struct = MRIread(uncorr_ima_path);

roi_ima = roi_struct.vol;
uncorr_ima = uncorr_ima_struct.vol;

[d1, d2, d3] = ind2sub(size(roi_ima),find(roi_ima~=0));
voxel_array = [d1, d2, d3];
uncorr_p_list  = uncorr_ima( find(roi_ima>0)  );
max_p =  max( uncorr_p_list  );
max_p_index = find( uncorr_p_list == max_p);

spherec = repmat(voxel_array(max_p_index,:), size(spherec_coordinate,1), 1) + spherec_coordinate;
empty_ima = roi_ima;
empty_ima(:)=0;

for n = 1:length(spherec)
    empty_ima(spherec(n,1),  spherec(n,2), spherec(n,3)) = 1;
end
roi_struct.vol = empty_ima;
MRIwrite(roi_struct, '/Users/boo/Desktop/pfc_6mm.nii');



%% extract clusters
mask_fc_targeting_mpfc_s = MRIread('/Users/boo/Desktop/fmri_script/analysis_FC_roi_searchlight/mask_fc_targeting_mpfc.nii');
mask_fc_targeting_mpfc = mask_fc_targeting_mpfc_s.vol;

cc = bwconncomp(bsxfun(@gt, mask_fc_targeting_mpfc, 0.95), 6);
nvox = length(mask_fc_targeting_mpfc(:));
cc.PixelIdxList(find(cellfun(@(x) length(x)<=10, cc.PixelIdxList)))=[];

for ith = 1:length(cc.PixelIdxList)
    ima_3d = zeros(size(mask_fc_targeting_mpfc));
    ima_3d(cc.PixelIdxList{ith})=1;
    
    mask_fc_targeting_mpfc_s.vol = ima_3d;
    MRIwrite(mask_fc_targeting_mpfc_s, ['/Users/boo/Desktop/',num2str(ith),'.nii']);
end



%% change 0 to nan
path = '/Users/boo/Desktop/fig_illustrator_mvpa_ima_example/';
brain_dir = dir(fullfile(path, 'pe*'));
brain_dir = strcat(path,  {brain_dir.name}');

for ith = 1:length(brain_dir)
    pimage = MRIread(brain_dir{ith});
    pimagevol = pimage.vol;
    
    pimagevol(find(pimagevol==0))= NaN;
    
    pimage.vol = pimagevol;
    
    name_pool = extractBetween(brain_dir{ith}, 'example/', '.nii');
    
    MRIwrite(pimage,[path, name_pool{1}, '_nan.nii']);
end




%% save a spheric roi

clear;
global_path =  '/Users/boo/Documents/degree_PhD/data_fmri';
keyw='w8s_lc_';

sub =8;
session = 1;

output_table = create_volumn_table_each_session_fsl(global_path, sub,session, keyw);  % create_volumn_table_each_session_mdf_fsl   create_volumn_table_each_session_walking_fsl
count_trialtype =  length(output_table(:,1));
spherec_coordinate = sphericalRelativeRoi(6,[2 2 2.3]);
mask_brain = output_table{1,1}.vol;
[fir_di, sec_di, thi_di] = size(mask_brain);
[d1, d2, d3] = ind2sub([fir_di, sec_di, thi_di],find(mask_brain~=0));
voxel_array = [d1, d2, d3];
count_voxel = length(voxel_array);
corr_3d_array = nan(count_trialtype, count_trialtype, count_voxel);


voxel_index = 40000;

spherec = repmat(voxel_array(voxel_index,:), size(spherec_coordinate,1), 1) + spherec_coordinate;
[row_ind, col_ind] = find(spherec(:,1) < 1 | spherec(:,2) < 1 | spherec(:,3) < 1 | spherec(:,1)>fir_di | spherec(:,2)>sec_di | spherec(:,3)>thi_di);
spherec (row_ind, :) = [];

output_brain = mask_brain;
output_brain(:) = 0;
for ith = 1:length(spherec(:,1))
    output_brain(spherec(ith,1), spherec(ith,2), spherec(ith,3)) = 100;
end
output_table{1,1}.vol = output_brain;
MRIwrite(output_table{1,1},'/Users/boo/Desktop/for_searchlight_show.nii');



%% mask out
pimage = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/mask_sub_l_hemi_lr_b_parietal.nii');
pimagevol = pimage.vol;

maskimage_parietal = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/mask_parietal.nii');
maskimage_parietal_vol = maskimage_parietal.vol;

maskimage_precun = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/mask_precuneus.nii');
maskimage_precun_vol = maskimage_precun.vol;

c_ima_parietal = pimagevol+maskimage_parietal_vol;
c_ima_parietal(find(c_ima_parietal<2))=0;
c_ima_parietal(find(c_ima_parietal==2)) = 1;

c_ima_precun = pimagevol+maskimage_precun_vol;
c_ima_precun(find(c_ima_precun<2))=0;
c_ima_precun(find(c_ima_precun==2)) = 1;

pimage.vol = c_ima_parietal;
MRIwrite(pimage,'/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/mask_sub_l_hemi_lr_b_parietal.nii');

pimage.vol = c_ima_precun;
MRIwrite(pimage,'/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/mask_sub_l_hemi_lr_b_precun.nii');





%% find peak
fnoise_struct = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/uncorrected_noise/tval_fnoise2s_fmap.nii');
fnoise_ima = fnoise_struct.vol;
tnoise_struct = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/uncorrected_noise/tval_tnoise2s_tmap.nii');
tnoise_ima = tnoise_struct.vol;

tnoisetmap_struct = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/uncorrected_noise/tval_cluster_tnoise2s_tmap.nii');
tnoise_tmap = tnoisetmap_struct.vol;

lmhpc_mask_struct = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/brainmask/single_HPCm_l_2mm.nii');
lmhpc_mask_ima = lmhpc_mask_struct.vol;
index_lmhpc = find(lmhpc_mask_ima>0);

mpfc_mask_struct = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/brainmask/mask_mpfc_4roi.nii');
mpfc_mask_ima = mpfc_mask_struct.vol;
index_mpfc = find(mpfc_mask_ima>0);

rectus_mask_struct = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/brainmask/mask_mtl_mpfc_standard/Rectus.nii');
rectus_mask_ima = rectus_mask_struct.vol;
index_rectus = find(rectus_mask_ima>0);
ba10_mask_struct = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/brainmask/mask_mtl_mpfc_standard/Frontal_Med_Orb.nii');
ba10_mask_ima = ba10_mask_struct.vol;
index_ba10 = find(ba10_mask_ima>0);


max(fnoise_ima(index_lmhpc))
max(tnoise_ima(index_lmhpc))

max(fnoise_ima(index_mpfc))
max(tnoise_ima(index_mpfc))


max(fnoise_ima(index_mpfc))
max(tnoise_ima(index_mpfc))
[d1, d2, d3] = ind2sub(size(fnoise_ima),find(fnoise_ima == max(fnoise_ima(index_mpfc))));
[d1, d2, d3]-1
[d1, d2, d3] = ind2sub(size(tnoise_ima),find(tnoise_ima == max(tnoise_ima(index_mpfc))));
[d1, d2, d3]-1


max(fnoise_ima(index_lmhpc))
max(tnoise_ima(index_lmhpc))
[d1, d2, d3] = ind2sub(size(fnoise_ima),find(fnoise_ima == max(fnoise_ima(index_lmhpc))));
[d1, d2, d3]-1
[d1, d2, d3] = ind2sub(size(tnoise_ima),find(tnoise_ima == max(tnoise_ima(index_lmhpc))));
[d1, d2, d3]-1





%%
path_b = '/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/raw_ego_back/';
brain_dir_b = dir(fullfile(path_b, 'fsl152*'));
brain_dir_b = strcat(path_b,  {brain_dir_b.name}');
ima_b = zeros(109, 91,91);
for ith_ima = 1:length(brain_dir_b)
    b_stuct = MRIread(brain_dir_b{ith_ima});
    b_ima = b_stuct.vol;
    ima_b = ima_b+b_ima;
end
ima_b = ima_b/19;

path_l = '/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/raw_ego_left/';
brain_dir_l = dir(fullfile(path_l, 'fsl152*'));
brain_dir_l = strcat(path_l,  {brain_dir_l.name}');
ima_l = zeros(109, 91,91);
for ith_ima = 1:length(brain_dir_l)
    l_stuct = MRIread(brain_dir_l{ith_ima});
    l_ima = l_stuct.vol;
    ima_l = ima_l+l_ima;
end
ima_l = ima_l/19;

path_r = '/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/raw_ego_right/';
brain_dir_r = dir(fullfile(path_r, 'fsl152*'));
brain_dir_r = strcat(path_r,  {brain_dir_r.name}');
ima_r = zeros(109, 91,91);
for ith_ima = 1:length(brain_dir_r)
    r_stuct = MRIread(brain_dir_r{ith_ima});
    r_ima = r_stuct.vol;
    ima_r = ima_r+r_ima;
end
ima_r = ima_r/19;


ima = ima_b - (ima_l+ima_r)/2;
b_stuct.vol = ima;
MRIwrite(b_stuct, ['/Users/boo/Desktop/b_lr.nii']);

ima = (ima_l+ima_r)/2- ima_b;
b_stuct.vol = ima;
MRIwrite(b_stuct, ['/Users/boo/Desktop/lr_b.nii']);




%%

cur_stuct = MRIread('/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/result_corr/2.5_right_back_clustere_corrp_tstat1.nii.gz');
cur_ima = cur_stuct.vol;
cur_ima(find(cur_ima>0.95))=1;
cur_ima(find(cur_ima<=0.95))=0;
cur_stuct.vol = cur_ima;
MRIwrite(cur_stuct, '/Users/boo/Desktop/mask_opa_right.nii');


