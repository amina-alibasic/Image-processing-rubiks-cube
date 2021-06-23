function [BW,maskedImage] = segmentImage(X)
% Threshold image - manual threshold
BW = X > 60;

% Open mask with square
width = 25; % manually chosen width to get rid of noise
se = strel('square', width);
BW = imopen(BW, se);

% Create masked image
maskedImage = X;
maskedImage(~BW) = 0;
end

