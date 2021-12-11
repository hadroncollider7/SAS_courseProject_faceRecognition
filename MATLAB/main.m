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
[featureVector1] = findfeatures('att_faces\s1\6.pgm',70);
[featureVector2] = findfeatures('att_faces\s8\2.pgm',70);

%% ******************************************************************
% Part 3: Training the face identification system
% Description: The first 5 pgm of each subject is used to train the
%   system by taking each image and converting it to a feature
%   vector of specified length. With 40 subjects, there will be
%   a total of 200 collections.
%********************************************************************
clear variables;
subject_range = [1 40]; % The range of subjects to train the system
dct_coef = 70;          % The cutoff length of the feature vector

% IMPORTANT: change to the correct filepath for att_faces 
%   in line 52 of the face_recog_knn_train.m file

% TRAIN THE kNN CLASSIFIER
[trdata_raw,trclass] = face_recog_knn_train(subject_range,dct_coef);

% ******************************************************************
% Part 4: Write a knn classifier function and do a performance
%   evaluation.
%********************************************************************
id = knn_classifier(1,dct_coef,trdata_raw,trclass);
points = success_rate(id);

%%
%********************************************************************
% PLOT 3D GRAPH
%********************************************************************

clear variables;
dct_coef = 25:15:100;
k = [1 3 5 7];
ID_successRate = zeros(length(dct_coef),length(k));
for i = 1:length(dct_coef)
    for j = 1:length(k)
        subject_range = [1 40]; % The range of subjects to train the system

        % TRAIN THE kNN CLASSIFIER
        [trdata_raw,trclass] = face_recog_knn_train(subject_range,dct_coef(i));

        id = knn_classifier(k(j),dct_coef(i),trdata_raw,trclass);
        ID_successRate(i,j) = success_rate(id);
    end
end

surf(k,dct_coef,ID_successRate);
xlabel('K');
ylabel('DCT Length');
zlabel('Success Rate')


























