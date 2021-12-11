%**************************************************************************
% A function to test the face id system. Be in the MATLAB project folder
%   to run this function.
% Inputs:
%   k = number of nearest neighbors
%   trdata_raw = matrix containing the training data of DCT vectors
%   trclass = class labels for each training data vector
% Outputs:
%   id_vector = system identification of unknown faces
%   per_eval = percentage of successful system identifications
%**************************************************************************

function [id_vector,perf_eval] = knn_classifier(k,dct_coeff,trdata_raw,trclass)
% Create a matrix containing the feature vectors of the unknown faces.
nsubjects = 40;
subjectRange = 1:nsubjects;
id_vector=[];
unknownFaces=[];
for i = 1:nsubjects
    % Loop through faces 6 through 10 of each subject
    % Need to be currently in the MATLAB project folder
    for j = 1:5
        fileName = ['att_faces\s' ...
            num2str(subjectRange(i)) '\' num2str(j+5) '.pgm'];

        % Run "findfeatures", which returns a DCT vector with a length
        %   defined by the dct_coeff
        face_feat(j,:) = findfeatures(fileName,dct_coeff);
    end
    unknownFaces = [unknownFaces face_feat(1:5,:)'];
end
unknownFaces = unknownFaces';
%**************************************************************************
% KNN CLASSIFIER
%**************************************************************************
knn_raw = zeros(1,nsubjects*5);         % to stores the unordered knn's
knn = zeros(1,nsubjects*5);             % to store the ordered knn's from least to greatest
knn_raw_class = zeros(1,nsubjects*5);   % to store the class label for each raw knn
knn_class = zeros(1,nsubjects*5);       % to store the class label for each ordered knn
for i = 1:nsubjects*5;
    L2_distance_vector = zeros(1,nsubjects*5);
    for j = 1:(nsubjects*5);
        subtract_vector = unknownFaces(i,:) - trdata_raw(j,:);
        % Take the norm and store in L2_distance
        L2_distance_vector(j) = norm(subtract_vector);
    end
    % Store the smallest L2 distance into an knn_vector_raw index
    knn_raw(i) = min(L2_distance_vector);
    % record class entry
    knn_raw_class(i) = trclass(find(L2_distance_vector==min(L2_distance_vector)));
end

id_vector = unknownFaces'; % For debug only.
end
