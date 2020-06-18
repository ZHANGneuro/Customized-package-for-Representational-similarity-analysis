#!/bin/bash

dd="/Users/boo/Documents/degree_PhD/data_fmri/manuscript_figure/ai_fig_for_illustartion_fig/highres_sub11.nii"


p1="flirt -in $dd "

p2=" -ref /Users/boo/Documents/degree_PhD/data_fmri/manuscript_figure/ai_fig_for_illustartion_fig/example_func_sub11.nii "

p22="-out /Users/boo/Documents/degree_PhD/data_fmri/manuscript_figure/ai_fig_for_illustartion_fig/downsample_t1_sub11.nii"

p3=" -init /Users/boo/Documents/degree_PhD/data_fmri/manuscript_figure/ai_fig_for_illustartion_fig/highres2example_func.mat -applyxfm"


$p1$p2$p22$p3