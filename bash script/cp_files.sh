#!/bin/bash


part0="cp "
part1="/Users/boo/Documents/degree_PhD/data_fmri/NAYA"
part2="/fc_smooth5_derivative_s"
part4=".feat/"
part5="stats/res4d.nii.gz"

to_path1=" /Users/boo/Documents/degree_PhD/data_fmri/residual_fc_5mm_derivative/"
naming2="residual_sub"
naming3="_s"
naming4=".nii.gz"



for sub in {8..26}
do
for sess in {1..4}
do

 $part0$part1$sub$part2$sess$part4$part5$to_path1$naming2$sub$naming3$sess$naming4

done
done
