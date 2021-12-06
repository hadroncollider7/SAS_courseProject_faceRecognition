%******************************************************************
% Part 1: Plot the 2D DCT map
% Version: 12-06-21
%******************************************************************
clear variables;
clf;

% READ AND PLOT THE IMAGE
[img,map] = imread('C:\Users\longc\Documents\GitHub\SAS_courseProject_faceRecognition\MATLAB\att_faces\s8\5.pgm');
    % read the image data (112x92 px) and store the data in an array (of size 112x92)
    %   img the array containing the image data
    %   map stores the image's associated color map.
% subplot(3,1,1), imshow(img,map);

img2dct = dct2(img);                    % get the 2ddct of the image
% subplot(3,1,2), imshow(img2dct,map);    % plot the 2ddct

imgrecover = idct2(img2dct);            % convert 2ddct back to matrix
% subplot(3,1,3), imshow(imgrecover,map); % plot the image converted back from 2ddct

%******************************************************************
% To show the energy compaction more clearly, the 2ddct is 
%   plotted in the log domain
%******************************************************************
%COMPUTE AND PLOT LOG MAGNITUDE OF 2DDCT
t1 = 0.01.*abs(img2dct);
t2 = 0.01*max(max(abs(img2dct)));
c_hat = 255*(log10(1+t1)/log10(1+t2));
imshow(c_hat,map);
title('Log Magnitude of 2-D DCT');
