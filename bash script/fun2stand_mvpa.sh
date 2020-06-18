#!/bin/bash

fsf_list=( /Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/fsl_glm_wft4_w8s_lc_w8s*)

for i in "${fsf_list[@]}"; do

  fsf_list2=($i/*.nii)

  for dd in "${fsf_list2[@]}"; do

    IN=$dd
    arrIN=(${IN//analysis_MVPA\// })
    file_name=${arrIN[1]}
    IN=$file_name
    arrIN=(${IN//\// })
    folder_name2=${arrIN[0]}

    IN=$file_name
    arrIN=(${IN//sub/ })
    sub=${arrIN[1]}
    IN=$sub
    arrIN=(${IN//_s/ })
    sub=${arrIN[0]}

    IN=$IN
    arrIN=(${IN//_s/ })
    sess=${arrIN[1]}
    IN=$sess
    arrIN=(${IN//.nii/ })
    sess=${arrIN[0]}

    p1="flirt -in $dd "

    p2=" -ref /usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz "

    p22="-out /Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA/"$folder_name2"/mni_sub"$sub"_s"$sess".nii"

    p3=" -init /Users/boo/Documents/degree_PhD/data_fmri/collection_fun2stand_reg/fun2stand_sub"$sub"_s"$sess".mat -applyxfm"

    $p1$p2$p22$p3

  done
done
