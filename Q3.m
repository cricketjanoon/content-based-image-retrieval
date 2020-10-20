clear;

gray_levels = 256;

% if set true then cdf is used as a feature, otherwise simple histogram
use_cdf_as_feature = 1; 

image_dir = 'C:\Users\cricketjanoon\_Repos\MATLAB\Digital Image Processing\EE512_HW2\CBIR';
filenames = dir(image_dir);
filenames = filenames(3:end); % because first two contains current directory and prev directory

% load the pre-calculated feature matrix
if use_cdf_as_feature==0
    load('feature_matrix_hist.mat'); 
else
    load('feature_matrix_cdf.mat'); 
end

% if no feature_matrix found in workspace, then compute again
if exist('feature_matrix','var')==0
    feature_matrix = zeros(numel(filenames), 256);
    for k = 1:numel(filenames)
        cur_img = imread(filenames(k).name);
        feature = extract_feature(cur_img, use_cdf_as_feature);
        feature_matrix(k,:) = feature';
        disp(k);
    end
    if use_cdf_as_feature==0
        save('feature_matrix_hist.mat','feature_matrix');
    else
        save('feature_matrix_cdf.mat','feature_matrix');
    end
end

% loading the query and calculating its feature
query_filename = '3689.jpg';    %'football31.jpg'; %"002904TB.jpg";
disp(query_filename);
query_image = imread(query_filename);
% imwrite(query_image, sprintf("q3_cdf03_0%d.png", 1));
subplot(2, 3, 1); imshow(query_image); title(sprintf("Query Image: (%s)", query_filename));
query_feature = double(extract_feature(query_image, use_cdf_as_feature));

% finding the distances with all the images features in database
distance_vector = zeros(numel(filenames, 1));
for i=1:numel(filenames)
    distance_vector(i,1) = euclidean_distance(query_feature, feature_matrix(i, :)');
end

% finding the minimum k distances
[~, indices] = mink(distance_vector, 5);

% displying the images with k min distances
for i=1:size(indices)
    name = filenames(indices(i)).name;
    % disp(name);
    img = imread(name);
    subplot(2, 3, i+1);
    imshow(img);
    % imwrite(img, sprintf("q3_cdf03_0%d.png", i+1));
    title(sprintf("Result: %d (%s)", i, name));
end

