#!/bin/bash



declare -a s1
s1[8]=466
s1[9]=469
s1[10]=497
s1[11]=471
s1[12]=493
s1[13]=466
s1[14]=500
s1[15]=494
s1[16]=466
s1[17]=484
s1[18]=463
s1[19]=477
s1[20]=479
s1[21]=470
s1[22]=457
s1[23]=492
s1[24]=478
s1[25]=487
s1[26]=480


declare -a s2
s2[8]=468
s2[9]=468
s2[10]=477
s2[11]=474
s2[12]=500
s2[13]=474
s2[14]=504
s2[15]=499
s2[16]=459
s2[17]=477
s2[18]=485
s2[19]=466
s2[20]=469
s2[21]=480
s2[22]=456
s2[23]=476
s2[24]=471
s2[25]=479
s2[26]=460

declare -a s3
s3[8]=464
s3[9]=470
s3[10]=471
s3[11]=470
s3[12]=502
s3[13]=469
s3[14]=471
s3[15]=485
s3[16]=463
s3[17]=491
s3[18]=468
s3[19]=471
s3[20]=472
s3[21]=471
s3[22]=464
s3[23]=471
s3[24]=467
s3[25]=488
s3[26]=465


declare -a s4
s4[8]=459
s4[9]=470
s4[10]=482
s4[11]=466
s4[12]=511
s4[13]=468
s4[14]=473
s4[15]=481
s4[16]=464
s4[17]=479
s4[18]=484
s4[19]=473
s4[20]=469
s4[21]=483
s4[22]=470
s4[23]=474
s4[24]=463
s4[25]=492
s4[26]=461

# generated on mac, path are for server
# mac
server_root=/gpfs/share/home/1401110602/fmri_script
TEMPLATE_PATH=/Users/boo/Documents/degree_PhD/data_fmri/bash/template_activity_with_hnd.fsf
standard_image_path=/gpfs/share/home/1401110602/fmri_script/brainmask/original_ima/MNI152_T1_2mm_template.nii

for sub in {8..26}; do
for session in {1..4}; do


if [ $session -eq 1 ];then
NUM_VOLUME=${s1[$sub]}
fi
if [ $session -eq 2 ];then
NUM_VOLUME=${s2[$sub]}
fi
if [ $session -eq 3 ];then
NUM_VOLUME=${s3[$sub]}
fi
if [ $session -eq 4 ];then
NUM_VOLUME=${s4[$sub]}
fi
OUTPUTDIR=$server_root/NAYA$sub/contrast_with_hnd_s$session
HEADMOVEMENT_PATH=$server_root/covariate_head6p_del/sub$sub"_s"$session".txt"
BOLD_IMAGE=$server_root/filtered_bold_smooth5/filtered_sub$sub"_s"$session".nii"

sed -e 's@OUTPUTDIR@'$OUTPUTDIR'@g' \
    -e 's@NUM_VOLUME@'$NUM_VOLUME'@g' \
    -e 's@HEADMOVEMENT_PATH@'$HEADMOVEMENT_PATH'@g' \
    -e 's@BOLD_IMAGE@'$BOLD_IMAGE'@g' \
    -e 's@NUM_SUB@'$sub'@g' \
    -e 's@standard_image_path@'$standard_image_path'@g' \
    -e 's@NUM_SESSION@'$session'@g' \
    -e 's@ROOTPATH@'$server_root'@g' <$TEMPLATE_PATH> /Users/boo/Documents/degree_PhD/data_fmri/bash/template_activity_with_hnd/fsf_sub$sub"_"s$session".fsf"

done
done
