function hist = my_imhist(img)
%MY_IMHIST: Calculates the histogram of the given image
%INPUT: 
%   img: image with (either graylevel or rgb)
%OUTPUT: 
%   hist: histogram of the given image

gray_levels = 256; % gray levels to be used later
hist = zeros(gray_levels, 1); % initializing hist with zeros
[r, c] = size(img); % getting rows and columns of the image

% looping over every pixel and recording freq of every intensity level
for i=1:r
    for j=1:c
        pixel_value = img(i,j);
        hist(pixel_value+1) = hist(pixel_value+1) + 1;
    end
end

end