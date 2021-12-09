%******************************************************************
% Part 1: Plot the 2D DCT map and learn to use some of the 
%   functions of the toolbox.
% Version: 12-06-21
%******************************************************************
clear variables;
clf;

% READ AND PLOT THE IMAGE
[img,map] = imread('s8\5.pgm');
    % read the image data (112x92 px) and store the data in an array (of size 112x92)
    %   img the array containing the image data
    %   map stores the image's associated color map.
subplot(3,1,1), imshow(img,map);

img2dct = dct2(img);                    % get the 2ddct of the image
subplot(3,1,2), imshow(img2dct,map);    % plot the 2ddct

imgrecover = idct2(img2dct);            % convert 2ddct back to matrix
subplot(3,1,3), imshow(imgrecover,map); % plot the image converted back from 2ddct

%******************************************************************
% To show the energy compaction more clearly, the 2ddct is 
%   plotted in the log domain
%******************************************************************
%COMPUTE AND PLOT LOG MAGNITUDE OF 2DDCT
t1 = 0.01.*abs(img2dct);
t2 = 0.01*max(max(abs(img2dct)));
c_hat = 255*(log10(1+t1)/log10(1+t2));
% imshow(c_hat,map);
% title('Log Magnitude of 2-D DCT');

%% ******************************************************************
% Part 2: Feature extraction
% Description: The features of the face is extracted using a
%   zigzag, 1D vector. Facial ID is done by comparing these
%   one dimensional vectors, rather than comparing the original
%   face matrix. The features vector is created from the 2ddct.
%********************************************************************
[featureVector1] = findfeatures('att_faces\s8\1.pgm',100);
[featureVector2] = findfeatures('att_faces\s8\2.pgm',100);

%% ******************************************************************
% Part 3: Training the face identification system
% Description: The first 5 pgm of each subject is used to train the
%   system by taking each image and converting it to a feature
%   vector of specified length. With 40 subjects, there will be
%   a total of 200 collections.
%********************************************************************
clear variables;
clf;
subject_range = [1 40]; % The range of subjects to train the system
dct_coef = 70;          % The cutoff length of the feature vector

% IMPORTANT: change to the correct filepath for att_faces 
%   in line 52 of the face_recog_knn_train.m file

% TRAIN THE kNN CLASSIFIER
[trdata_raw,trclass] = face_recog_knn_train(subject_range,dct_coef);

%% ******************************************************************
% Part 4: Performance evaluation of the face identification system
% Description: 
%********************************************************************
% (1) take the remaining files 6.pgm to 10.pgm of each subject and use findfeatures 

% (2) compare each feature vector with every vector in trdata_raw to get the L2
%     distance
%     L2 = norm(([B1]-[A1])^2+([B2]-[A2])^2+...([B70]-[A70])^2)

% (3) find the k smallest L2 distances, where k = 1,3,5, or 7. create an array
%     where the lowest L2 is the first element, 2nd lowest is 2nd element, etc.


% (4) take a majority vote to identify the subject (if tie, take the lowest L2 value)
%     do not use the mode function in MATLAB.

% (5) Do for 5 Files different from training for each subject and all 40
%     subjects to get 200 evaluations.

% (6) Calculate Identification success rate = (# subjects identified
%     correctly) / 200 expressed as a percent

% (7) Use MATLAB to generate a 3D plot 
%     x-axis = k
%     y-axis = dctlength
%     z-axis = identification success rate


