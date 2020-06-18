#!/bin/bash


fsf_list=(/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/result_ego_both-back*)
for complete_path in "${fsf_list[@]}";
do
  (
  p1="randomise -i "
  path_4d=$complete_path/4d.nii
  IN="$path_4d"
  arrIN=(${IN//result_ego_both-back\// })
  file_name2=${arrIN[1]}
  out_path="/Users/boo/Desktop/2.5_"$file_name2
  other_string=" -1 -c 2.5 -n 5000"
  #other_string=" -1 -x"
  #add_mask=" -m /Users/boo/Documents/degree_PhD/data_fmri/brainmask/mask_MTL2.nii"
  cmd=$p1$path_4d" -o "$out_path$other_string$add_mask

  eval $cmd
  )&
  if (( $(wc -w <<<$(jobs -p)) % 6 == 0 )); then wait; fi
done


# fsf_list=(/Users/boo/Documents/degree_PhD/data_fmri/analysis_contrast_direction/result_ego_both-back)
# for complete_path in "${fsf_list[@]}";
# do
#   (
#   p1="randomise -i "
#   path_4d=$complete_path/4d.nii
#
#   IN="$complete_path"
#   arrIN=(${IN//analysis_contrast_direction\// })
#   file_name2=${arrIN[1]}
#   out_path="/Users/boo/Desktop/vb_"$file_name2
#   other_string=" -1 -x"
#   #add_mask=" -m /Users/boo/Documents/degree_PhD/data_fmri/brainmask/mask_MTL2.nii"
#   cmd=$p1$path_4d" -o "$out_path$other_string
#
#   eval $cmd
#   )&
#   if (( $(wc -w <<<$(jobs -p)) % 8 == 0 )); then wait; fi
# done