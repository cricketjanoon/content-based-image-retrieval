clear;

input_img = imread('mri.pgm');
ref_img = imread('moon.pgm');

gray_levels = 256;

% calculating the cdf of the input and reference image
[input_equalized_img, input_equalized_hist, cdf_input_img] = my_histeq(input_img);
[ref_equalized_img, ref_equalized_hist, cdf_ref_img] = my_histeq(ref_img);

% inverse mapping the equlized histogram to the specified histogram
mapping = uint8(zeros(256,1));
for i = 1 : gray_levels
    [~,ind] = min(abs(cdf_input_img(i) - cdf_ref_img));
    mapping(i) = ind-1;
end
desired_image = mapping(double(input_img)+1);

% plotting the original image
subplot(1, 2, 1);
imshow(input_img);
title("Original Image");

% plotting the refrence image
subplot(1, 2, 2);
imshow(desired_image);
title("Matched Histogram Image");
