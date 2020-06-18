#!/bin/bash

# fsf_list=(/Users/boo/Desktop/fmri_script/fc_analysis/rois/roi_1*)
#
# for i in "${fsf_list[@]}"; do
#


# # #################################################
# # # stand2fun roi maker
# # # flirt   -ref  -in  -out -init .mat -applyxfm
# # #################################################
#  #/Users/boo/Documents/degree_PhD/data_fmri/bash
#
# root_path="/Users/boo/Documents/degree_PhD/data_fmri/"
# roi_folder_name="analysis_FC_roi_searchlight/rois/"
# roi_list=(/Users/boo/Documents/degree_PhD/data_fmri/analysis_FC_roi_searchlight/rois/mask*)
# for i in "${roi_list[@]}"; do
#
#   IN=$i
#   arrIN=(${IN//mask_/ })
#   roi_name=${arrIN[1]}
#   IN=$roi_name
#   arrIN=(${IN//.nii/ })
#   roi_name=${arrIN[0]}
#
#   for sub in {8..26}; do
#     for sess in {1..4}; do
#       refer_ima=$root_path"residual_fc_5mm_derivative_bandpass_single_ima"/bandpass_sub$sub"_s"$sess.nii.gz
#       mat_file=$root_path"collection_stand2fun_reg"/stand2fun_sub$sub"_s"$sess.mat
#       output_ima=$root_path$roi_folder_name"folder_"$roi_name"/sub"$sub"_s"$sess.nii
#       mkdir $root_path$roi_folder_name"folder_"$roi_name
#       flirt -in $i -ref $refer_ima -init $mat_file -out $output_ima -applyxfm
#     done
#   done
# done




# ################################################
# stand2fun roi maker
# flirt   -ref  -in  -out -init .mat -applyxfm
################################################
# /Users/boo/Documents/degree_PhD/data_fmri/bash
# /Users/boo/Documents/degree_PhD/data_fmri/brainmask/
root_path="/Users/boo/Documents/degree_PhD/data_fmri/"
# mask_HPCa_mni
# mask_HPCm_mni
# mask_HPCp_mni
# mask_Frontal_Sup_Medial_mni
# mask_Frontal_Med_Orb_mni
# mask_Rectus_mni

i="/Users/boo/Documents/degree_PhD/data_fmri/brainmask/mask_outside_brain.nii"
for sub in {8..26}; do
  for sess in {1..4}; do
    refer_ima=$root_path"residual_fc_5mm_derivative_bandpass_single_ima"/bandpass_sub$sub"_s"$sess.nii.gz
    mat_file=$root_path"collection_stand2fun_reg"/stand2fun_sub$sub"_s"$sess.mat
    output_ima="/Users/boo/Documents/degree_PhD/data_fmri/brainmask/roi_native_noise/sub"$sub"_s"$sess".nii"
    flirt -in $i -ref $refer_ima -init $mat_file -out $output_ima -applyxfm
  done
done



# ####################################################################################
# extract signal from native space
# fslmeants -i filtered_func.nii.gz -o my_timecourse.txt -m your_roi_mask.nii.gz
# ####################################################################################

# roi_dir=/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/ROIs/mask_parietal/
# condi_dir=(/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/raw_timeseries_*)
#
# for i in "${condi_dir[@]}"; do
#     IN=$i
#     arrIN=(${IN//raw_timeseries_/ })
#     condi_name=${arrIN[1]}
#
#   for sub in {8..26}; do
#     for sess in {1..4}; do
#
#       tc_ima=$i/fc_bandpass_sub_"$sub"_s"$sess".nii
#       output_txt=$roi_dir$condi_name"_sub"$sub"_s"$sess".txt"
#       roi_ima=$roi_dir"sub"$sub"_s"$sess".nii.gz"
#       fslmeants -i $tc_ima -o $output_txt -m $roi_ima
#     done
#   done
# done
#
#

