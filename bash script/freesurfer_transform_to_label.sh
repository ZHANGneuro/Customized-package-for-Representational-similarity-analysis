#!/bin/bash

# tksurfer fsaverage lh inflated

 # bbregister --mov /Users/boo/Documents/degree_PhD/data_fmri/brainmask/original_ima/standard/MNI152_T1_2mm_brain.nii.gz  --T1 --s fslmni152 --init-fsl --reg /Users/boo/Desktop/register_fslmni152_2mm.dat --12

#tkmedit fsaverage T1.mgz -overlay /Users/boo/Desktop/fmri_script/analysis_MVPA/filtered_Dec31/wr_cor_20181129_f4s_20181129_fmap2552.nii -overlay-reg $FREESURFER_HOME/register_2mm.dat
#tksurfer fslmni152 lh inflated -overlay /Users/boo/Desktop/fmri_script/analysis_MVPA/filtered_Dec31/wr_cor_20181129_f4s_20181129_fmap2552.nii -overlay-reg $FREESURFER_HOME/register_2mm.dat


# export_path=/Users/boo/Desktop/MEG_data_script/aal_51/mgh_fs/
# file_list=(/Users/boo/Desktop/MEG_data_script/aal_51/MTL*)
# for i in "${file_list[@]}"; do
#   IN=$i
#   arrIN=(${IN//aal_51\// })
#   file_name=${arrIN[1]}
#   IN="$file_name"
#   arrIN=(${IN//".nii"/ })
#   file_name=${arrIN[0]}
#
#   output_path_lh=$export_path$file_name"_lh_fs.mgh"
#   output_path_rh=$export_path$file_name"_rh_fs.mgh"
# #register_fslmni152_2mm
#   mri_vol2surf --mov $i --reg $FREESURFER_HOME/register_2mm.dat --hemi "rh" --out $output_path_rh
#   mri_vol2surf --mov $i --reg $FREESURFER_HOME/register_2mm.dat --hemi "lh" --out $output_path_lh
# done



## mgh to label
export_path=/Users/boo/Desktop/MEG_data_script/aal_51/labels_frequency_each_band_fs/
file_list=(/Users/boo/Desktop/MEG_data_script/aal_51/mgh_fs/MTL*rh*.mgh)
for i in "${file_list[@]}"; do
  IN=$i
  arrIN=(${IN//mgh_fs\// })
  file_name=${arrIN[1]}
  IN=$file_name
  arrIN=(${IN//./ })
  file_name=${arrIN[0]}
  output_path=$export_path$file_name
  mri_cor2label --i $i --id 1 --l $output_path --surf fsaverage "rh" #fslmni152
done





# mri_annotation2label --subject fslmni152 \
#   --hemi lh \
#   --labelbase /Users/boo/Desktop/fmri_script/brainmask/aal/aal_freesurfer_label/aparc-lh
