function [pixels] = findPixels(image)
% finds the center of the square 
% and returns RGB pixel values from the center
        [rows, columns,~] = size(image);
        centerR = rows / 2;
        centerC = columns / 2;
        pixels = impixel(image,centerC,centerR);
end
