function [distance] = euclidean_distance(image1, image2)
    distance = sqrt(sum((image1 - image2).^ 2));
end