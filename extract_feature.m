function [feature] = extract_feature(img, cdf)
%feature = extract_feature(img, cdf)
%extracts features from the given image
%INPUT: 
%   img: given image (grayscale or rgb)
%   cdf: if set to 1 then it returns the cdf otherwise it returns the histogram
%   as feature
%OUTPUT: 
%   feature: depending on the value of cdf, it is the required feature of
%   the image

[r, c] = size(img); % gettings the rows and column of the image
number_of_pixels = r*c; % total number of pixels in the image
gray_levels = 256;

my_hist = my_imhist(img); % calculate histogram of the image

% if user want hist as their feature then return
if cdf==0
    feature = my_hist;
    return
end

prob = my_hist/number_of_pixels; % calculate PMF of the histograms (or normalized histogram)

% cdf of the original image
cdf = zeros(gray_levels, 1);
cdf(1) = prob(1);
for i=2:256
    cdf(i) = cdf(i-1)+prob(i);
end

% discretizing the cdf with 256 gray levels
cdf = cdf * (gray_levels-1);
feature = uint8(cdf);


