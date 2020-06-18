
function aal_roi_pool = load_aal_label102


% sorting
aal_roi_path = '/Users/boo/Documents/degree_PhD/data_fmri/brainmask/aal/aal_102/';
aal_roi_dir = dir(fullfile(aal_roi_path, '*.nii'));
aal_roi_pool =  strcat(aal_roi_path, {aal_roi_dir.name}');

for ith_line = 1:length(aal_roi_pool)
    if contains(aal_roi_pool{ith_line,1}, '_L')
        aal_roi_pool{ith_line,2} = 'Left';
    elseif contains(aal_roi_pool{ith_line,1}, '_R')
        aal_roi_pool{ith_line,2} = 'Right';
    else
        aal_roi_pool{ith_line,2} = 'both';
    end
    if contains( aal_roi_pool{ith_line,1},  'Amyg' ) | contains( aal_roi_pool{ith_line,1},  'Thalamus' )| ...
            contains( aal_roi_pool{ith_line,1},  'Insula' ) | contains( aal_roi_pool{ith_line,1},  'Olfactory')| ...
            contains( aal_roi_pool{ith_line,1},  'Olfactory') | contains( aal_roi_pool{ith_line,1},  'Pallidum') | ...
            contains( aal_roi_pool{ith_line,1},  'Putamen') |  contains( aal_roi_pool{ith_line,1},  'Cingulate') | ...
            contains( aal_roi_pool{ith_line,1},  'Caudate')
        aal_roi_pool{ith_line,3} = 'sub_cortical';
    end
    if contains( aal_roi_pool{ith_line,1},  'Frontal' ) | contains( aal_roi_pool{ith_line,1},  'OFC' ) | ...
            contains( aal_roi_pool{ith_line,1},  'Rectus' )
        aal_roi_pool{ith_line,3} = 'Frontal';
    end
    if contains( aal_roi_pool{ith_line,1},  'Enterinal' ) | contains( aal_roi_pool{ith_line,1},  'Hippo' )  | ...
            contains( aal_roi_pool{ith_line,1},  'Para' ) |  contains( aal_roi_pool{ith_line,1},  'Para' ) | ...
            contains( aal_roi_pool{ith_line,1},  'Perirhinal' )
        aal_roi_pool{ith_line,3} = 'Medial_temporal';
    end
    if contains( aal_roi_pool{ith_line,1},  'Lingual' ) | contains( aal_roi_pool{ith_line,1},  'Occipital' ) | ...
            contains( aal_roi_pool{ith_line,1},  'Calcarine' ) | contains( aal_roi_pool{ith_line,1},  'Cuneus' )
        aal_roi_pool{ith_line,3} = 'Occipital';
    end
    if contains( aal_roi_pool{ith_line,1},  'Heschl' ) | contains( aal_roi_pool{ith_line,1},  'Fusiform' ) | ...
            contains( aal_roi_pool{ith_line,1},  'Temporal' )
        aal_roi_pool{ith_line,3} = 'Lateral_temporal';
    end
    if contains( aal_roi_pool{ith_line,1},  'Paracen' ) | contains( aal_roi_pool{ith_line,1},  'Postcen' ) | ...
            contains( aal_roi_pool{ith_line,1},  'Precentral' ) | contains( aal_roi_pool{ith_line,1},  'Rolandic' ) | ...
            contains( aal_roi_pool{ith_line,1},  'Motor' )
        aal_roi_pool{ith_line,3} = 'Motor';
    end
    if contains( aal_roi_pool{ith_line,1},  'Parietal' ) | contains( aal_roi_pool{ith_line,1},  'Precuneus' ) | ...
            contains( aal_roi_pool{ith_line,1},  'SupraMar' ) |  contains( aal_roi_pool{ith_line,1},  'Angular' )
        aal_roi_pool{ith_line,3} = 'Parietal';
    end
    if contains( aal_roi_pool{ith_line,1},  'RSC_' )
        aal_roi_pool{ith_line,3} = 'Parietal';
    end
end
aal_roi_pool = sortrows(aal_roi_pool,[2,3]);
