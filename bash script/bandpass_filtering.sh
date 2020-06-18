#!/bin/bash
 # -bptf  <hp_sigma> <lp_sigma> : (-t in ip.c)
 # Bandpass temporal filtering; nonlinear highpass and Gaussian linear lowpass
 # (with sigmas in volumes, not seconds); set either sigma<0 to skip that filter
# https://www.jiscmail.ac.uk/cgi-bin/webadmin?A2=ind1205&L=FSL&P=R57592
# https://www.jiscmail.ac.uk/cgi-bin/webadmin?A2=ind1110&L=FSL&P=R59117

# bandpass filter 0.01 0.1
# part0="fslmaths "
# part1="/gpfs/share/home/1401110602/fmri_script/fc_residual_5mm_derivative/residual_sub"
# part2="_s"
# part3=".nii"
# part5=" -bptf 25 2.5"
#
# to_path1=" /gpfs/share/home/1401110602/fmri_script/fc_residual_5mm_derivative_bandpass/"
# naming2="bandpass_sub"
# naming3="_s"
# naming4=".nii"
# for sub in {23..26}
# do
# for sess in {1..4}
# do
#  $part0$part1$sub$part2$sess$part3$part5$to_path1$naming2$sub$naming3$sess$naming4
# done
# done



# bandpass filter 0.02 0.25
# Functional Connectivity With the Hippocampus During Successful Memory Formation
# sigma = 1/(2*TR*cutoff_in_hz)

part0="fslmaths "
part1="/Users/boo/Documents/degree_PhD/data_fmri/residual_fc_5mm_derivative/residual_sub"
part2="_s"
part3=".nii.gz"
part5=" -bptf 12.5 1"

to_path1=" /Users/boo/Documents/degree_PhD/data_fmri/residual_fc_5mm_derivative_bandpass025002/"
naming2="bandpass_sub"
naming3="_s"
naming4=".nii"
for sub in {8..26}
do
for sess in {1..4}
do
 $part0$part1$sub$part2$sess$part3$part5$to_path1$naming2$sub$naming3$sess$naming4
done
done