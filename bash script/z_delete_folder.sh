#!/bin/bash



# str1="/gpfs/share/home/1401110602/fmri_script/NAYA"
#
#
# for sub in {8..26}
# do
# for sess in {1..4}
# do
# str2="/MVPA_sta*"
#
# rm -rf $str1$sub$str2
#
# done
# done




fsf_list=(/Users/boo/Desktop/fmri_script/analysis_itm/rois/folder_roi*)

for i in "${fsf_list[@]}"; do

rm $i/time*


done
