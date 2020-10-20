function [equalized_img, equalized_hist, cdf] = my_histeq(img)
%my_histeq: Performs the histogram equalizatiaon of the image
%INPUT: 
%   img: image with (either graylevel or rgb)
%OUTPUT: 
%   equalized_img: Transformed image with histogram equalization
%   equalized_hist: Histogram of the transformed image
%   cdf: commulative density function of original image


[r, c] = size(img); % getting rows and columns of given image
number_of_pixels = r*c; % total pixels in the image M*N
gray_levels = 256;

my_hist = my_imhist(img); % calculate histogram of the image
prob = my_hist/number_of_pixels; % calculate PMF of the histograms (or normalized histogram)

% cdf of the original image
cdf = zeros(gray_levels, 1);
cdf(1) = prob(1);
for i=2:256
    cdf(i) = cdf(i-1)+prob(i);
end

% discretizing the cdf with 256 gray levels
cdf = cdf * (gray_levels-1);
cdf = uint8(cdf);

% mapping the calculated cdf to the new image
equalized_img = img;
for i=1:r
    for j=1:c
        equalized_img(i, j) = cdf(img(i, j)+1);
    end
end

% calculating the historam of the transformed image
equalized_hist = my_imhist(equalized_img);

end

