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
subtraction_matrix = [];


id_vector = unknownFaces'; % For debug only.
end
