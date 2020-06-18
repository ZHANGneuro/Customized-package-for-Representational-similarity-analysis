#!/bin/bash

# fsf_list=(/Users/boo/Desktop/fmri_script/fc_analysis/rois/roi_1*)
#
# for i in "${fsf_list[@]}"; do
#

# #################################################
# # stand2fun roi maker
# # flirt   -ref  -in  -out -init .mat -applyxfm
# #################################################
#
#
# root_path="/Users/boo/Desktop/fmri_script/"
# output_folder_name="analysis_FC_roi_searchlight/"
# roi_list=(/Users/boo/Desktop/fmri_script/brainmask/aal/aal_51/*.nii)
# for i in "${roi_list[@]}"; do
#
#   IN=$i
#   arrIN=(${IN//aal_51\// })
#   roi_name=${arrIN[1]}
#   IN=$roi_name
#   arrIN=(${IN//.nii/ })
#   roi_name=${arrIN[0]}
#
#   for sub in {8..26}; do
#     for sess in {1..4}; do
#       refer_ima=$root_path"residual_fc_5mm_derivative_bandpass_single_ima"/bandpass_sub$sub"_s"$sess.nii
#       mat_file=$root_path"collection_stand2fun_reg"/stand2fun_sub$sub"_s"$sess.mat
#       output_ima=$root_path$output_folder_name"folder_"$roi_name"/sub"$sub"_s"$sess.nii
#       mkdir $root_path$output_folder_name"folder_"$roi_name
#       flirt -in $i -ref $refer_ima -init $mat_file -out $output_ima -applyxfm
#     done
#   done
#
#
# done

#################################################
# stand2fun roi maker
# flirt   -ref  -in  -out -init .mat -applyxfm
#################################################

root_path="/Users/boo/Documents/degree_PhD/data_fmri/"
roi_list=(/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/raw_fc_r_map_*)

for i in "${roi_list[@]}"; do

  file_list=($i/mask_*)
  for cur_file in "${file_list[@]}"; do

    IN=$cur_file
    arrIN=(${IN//mask_/ })
    seg1=${arrIN[1]}
    IN=$seg1
    arrIN=(${IN//_final_/ })
    roi_name=${arrIN[0]}
    seg2=${arrIN[1]}
    arrIN=(${seg2//_s/ })
    IN=${arrIN[0]}
    seg3=(${IN//_/ })
    no_sub=${seg3[1]}
    seg4=${arrIN[1]}
    seg5=(${seg4//./ })
    no_s=${seg5[0]}

    refer_ima=$root_path"residual_fc_5mm_derivative_bandpass_single_ima/bandpass_sub"$no_sub"_s"$no_s".nii"
    mat_file=$root_path"collection_stand2fun_reg/stand2fun_sub"$no_sub"_s"$no_s".mat"
    output_ima=$i"/mni_"$roi_name"_"$sub$no_sub"_s"$no_s".nii"
    echo flirt -in $cur_file -ref $refer_ima -init $mat_file -out $output_ima -applyxfm


  done
done


