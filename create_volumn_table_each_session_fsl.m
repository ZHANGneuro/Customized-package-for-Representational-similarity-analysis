

function output_table = create_volumn_table_each_session_fsl(global_path, sub,session, curr_period)


[table_rawdata, table_time] = extract_behavioral_table_fmri (global_path, sub);

sub_folder = ['/fsl_', curr_period, 's', num2str(session), '.feat/'];

path_beta = [global_path, '/NAYA', num2str(sub), sub_folder,'stats/'];
beta_dir = dir(fullfile(path_beta, 'pe*.nii'));
if isempty(beta_dir)
    beta_dir = dir(fullfile(path_beta, 'pe*.nii.gz'));
    beta_list = strcat(path_beta,  {beta_dir.name}');
    for n = 1:length(beta_list(:,1))
        gunzip(beta_list{n});
    end
end
beta_dir = dir(fullfile(path_beta, 'pe*.nii'));
beta_list = strcat(path_beta,  {beta_dir.name}');
temp_rank_ith = zeros(length(beta_list),1);
str1 = [global_path, '/NAYA', num2str(sub), sub_folder,'stats/pe'];
str2 = '.nii';
for n = 1:length(beta_list)
    temp_name = extractBetween(beta_list{n}, str1, str2);
    temp_rank_ith(n,1) = str2double(temp_name{1});
end
[ranked,sort_index] = sort(temp_rank_ith);
beta_list = beta_list(sort_index);
beta_list = beta_list(1:36);

table_rawdata_by_session = cell(1,17);
table_rawdata_by_time = cell(1,13);
temp_ith = find( cellfun(@(x,y)  ~strcmp(x, 'NA') & strcmp(y, num2str(session)), table_time{1,12}, table_time{1,13}));
for each_col = 1:length(table_rawdata(1,:))
    table_rawdata_by_session{1, each_col} = table_rawdata{1, each_col}(temp_ith);
end
for each_col = 1 : length(table_time(1,:))
    table_rawdata_by_time{1, each_col} = table_time{1, each_col}(temp_ith);
end

button_list = cell(36,1);
for ith_trial = 1:36
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'321') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'left')
        button_list{ith_trial} = 3;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'321') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'back')
        button_list{ith_trial} = 2;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'321') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'right')
        button_list{ith_trial} = 1;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'312') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'left')
        button_list{ith_trial} = 3;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'312') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'back')
        button_list{ith_trial} = 1;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'312') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'right')
        button_list{ith_trial} = 2;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'231') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'left')
        button_list{ith_trial} = 2;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'231') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'back')
        button_list{ith_trial} = 3;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'231') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'right')
        button_list{ith_trial} = 1;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'213') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'left')
        button_list{ith_trial} = 2;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'213') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'back')
        button_list{ith_trial} = 1;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'213') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'right')
        button_list{ith_trial} = 3;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'132') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'left')
        button_list{ith_trial} = 1;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'132') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'back')
        button_list{ith_trial} = 3;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'132') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'right')
        button_list{ith_trial} = 2;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'123') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'left')
        button_list{ith_trial} = 1;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'123') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'back')
        button_list{ith_trial} = 2;
    end
    if strcmp(table_rawdata_by_session{1,12}{ith_trial},'123') & strcmp(table_rawdata_by_session{1,13}{ith_trial},'right')
        button_list{ith_trial} = 3;
    end
end
button_list = cell2mat(button_list);

num_of = length(table_rawdata_by_session{1,1});
output_table = cell(num_of,18);
for i = 1:num_of
    temp_map = table_rawdata_by_session{1,2}{i}; % map
    temp_dire = table_rawdata_by_session{1,3}{i}; % ed
    temp_facing = table_rawdata_by_session{1,8}{i}; % f doll
    temp_ego = table_rawdata_by_session{1,10}{i}; % egocentric
    temp_target = table_rawdata_by_session{1,11}{i}; % t doll
    temp_rotation = table_rawdata_by_session{1,15}{i}; % angle
    temp_fcha_location = table_rawdata_by_session{1,17}{i}; %
    temp_tcha_location = table_rawdata_by_session{1,18}{i}; %
    temp_parse = strsplit(temp_rotation, '??');
    temp_angle = temp_parse{1};
    temp_parse2 = strsplit(temp_angle, '_');
    td = temp_parse2{1};
    ta = temp_parse2{2};
    
    temp_hand = table_rawdata_by_session{1,16}{i}; % hand
    temp_correctness = table_rawdata_by_session{1,14}{i}; % correctness
    if strcmp(temp_hand, '1')
        temp_hand = 'left_hand';
    end
    if strcmp(temp_hand, '0')
        temp_hand = 'right_hand';
    end
    %     temp_identifier = ['map ',temp_map];
    temp_identifier = ['m',temp_map,' fc',temp_facing,' tc', temp_target, ' ',temp_ego];
    beta_ima = MRIread(beta_list{i});
    output_table{i,1} =beta_ima;
    output_table{i,2} = temp_map; % maps
    output_table{i,3} = temp_dire; % dire
    output_table{i,4} = temp_facing; % fdo
    output_table{i,5} = temp_ego; % egoentric
    output_table{i,6} = temp_target; % tdo
    output_table{i,7} = temp_identifier; % identifier
    output_table{i,8} = [td(1) '_' ta]; % rotation
    output_table{i,9} = temp_correctness; % correctness
    output_table{i,10} = temp_hand; % correctness
    output_table{i,12} = td(1);
    output_table{i,13} = ta;
    output_table{i,14} = [temp_map temp_dire];
    output_table{i,15} = temp_fcha_location;
    output_table{i,16} = temp_tcha_location;
    output_table{i,17} = ['Trial ', num2str(i)];
    output_table{i,18} = button_list(i);
end



