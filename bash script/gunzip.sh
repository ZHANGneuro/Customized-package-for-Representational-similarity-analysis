#!/bin/bash

fsf_list=( /Users/boo/Documents/degree_PhD/data_fmri/analysis_MVPA_roi/folder*)


for i in "${fsf_list[@]}"; do


  fsf_list2=($i/*)


  for ii in "${fsf_list2[@]}"; do



gunzip $ii

done
done
