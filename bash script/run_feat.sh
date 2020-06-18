#!/bin/bash

#/mnt/hgfs/zhang_bo/fmri_script/bash
#/Users/boo/Desktop/fmri_script/bash
fsf_list=(/gpfs/share/home/1401110602/fmri_script/bash/t4s_lc/fsf*)

for i in "${fsf_list[@]}"; do
  (
    feat $i
  )&
  if (( $(wc -w <<<$(jobs -p)) % 4 == 0 )); then wait; fi
done
