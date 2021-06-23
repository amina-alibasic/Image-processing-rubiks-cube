clear all   
close all
%% 
Iorg = imread('mix2.jpg'); % read an image into the workspace
figure,subplot(1,3,1); imshow(Iorg); title('Original image');
Igr = rgb2gray(Iorg); % convert the image to grayscale
subplot(1,3,2), imshow(Igr); title('Grayscale');
Igs = imadjust(Igr); % adjust the histogram
subplot(1,3,3), imshow(Igs); title('After imadjust()');
%% Variables needed
resultMatrix = strings(3,3);
imagesCell = cell([9 1]);
colors = strings;
%% Process the image
% Segment the image and get binary image
[Ibw,Imask] = segmentImage(Igs);

%% Rotate the binary image to get the right order of bounding boxes
% Aproximately 1,6 degrees in clockwise direction will do the trick
figure,subplot(1,3,1); imshow(Ibw); title('Binary image');
Ibw = imrotate(Ibw,-1.6);
subplot(1,3,2); imshow(Ibw); title('Rotated bw image');
Iorg = imrotate(Iorg,-1.6); 
% rotate the original image as well because we need to get BBoxes as accurate as possible

%% Call regionprops for bounding boxes
bboxes = regionprops(Ibw, 'BoundingBox');

%% Draw the boxes
subplot(1,3,3); imshow(Ibw); title('BW image with BBoxes');
hold on
for k = 2 : 10 % the first bounding box is the whole image
    CurrBB = bboxes(k).BoundingBox;
    rectangle('Position', [CurrBB(1),CurrBB(2),CurrBB(3),CurrBB(4)], 'EdgeColor', 'r', 'LineWidth',2);
    % startx and starty are coordinates for text labels of the boxes
    % +5 and +15 are for better text position inside the box
    starty = CurrBB(1)+5;
    startx = CurrBB(2)+150;
    str = sprintf('Box%d',k-1);
    text(starty,startx,str,'Color','blue','FontSize',14);
end
hold off

%% Map the colors
figure;
for k = 1 : 9
        box = bboxes(k+1).BoundingBox;
        % Cut each square into a new image
        % Place image of each square into an array (cell)
        imagesCell{k} = imcrop(Iorg,box); 
        colors(k) = whichColor(imagesCell{k}); % get RGB values and detect the color
        % put each color into colors (array of strings)
        subplot(3,3,k), imshow(imagesCell{k});
end

%% Put the color values into result matrix
resultMatrix(3,1) = colors(1);
resultMatrix(2,1) = colors(2);
resultMatrix(1,1) = colors(3);
resultMatrix(3,2) = colors(4);
resultMatrix(2,2) = colors(5);
resultMatrix(1,2) = colors(6);
resultMatrix(3,3) = colors(7);
resultMatrix(2,3) = colors(8);
resultMatrix(1,3) = colors(9);

disp('Result:');
disp(resultMatrix);
