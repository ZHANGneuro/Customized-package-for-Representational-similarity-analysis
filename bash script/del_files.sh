#!/bin/bash

part0="rm -rf "




for sub in {8..26}
do

part1=/Users/boo/Documents/degree_PhD/data_fmri/NAYA$sub/fsl*lc_*.feat
$part0$part1

done





