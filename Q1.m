clear;

filenames{1} = 'university.pgm';
filenames{2} = 'asian.jpg';
filenames{3} = 'landscape.pgm';
filenames{4} = 'vislab.jpg';

number_of_images = 5;

for i=1:number_of_images
    if i==5
        img = uint8(50*randn(100, 100) + 128);
    else
        img = imread(filenames{i});
    end
    
    % applying histogram equalization
    equalized_img = my_histeq(img);
    
    % plotting the original image vs transformed image
    subplot(2, number_of_images, i);
    imshow(img); title("Original Image");
    subplot(2, number_of_images, i+5);
    imshow(equalized_img); title("Transformed Image");
    
    % saving images to include in report
    imwrite(img, sprintf("img%d_original.jpeg", i), 'jpeg');
    imwrite(equalized_img, sprintf("img%d_transformed.jpeg", i), 'jpeg');
end