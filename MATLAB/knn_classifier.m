%**************************************************************************
% A function to test the face id system. Be in the MATLAB project folder
%   to run this function.
% Inputs:
%   k = number of nearest neighbors
%   trdata_raw = matrix containing the training data of DCT vectors
%   trclass = class labels for each training data vector
% Outputs:
%   id_vector = system identification of unknown faces
%**************************************************************************

function id_vector = knn_classifier(k,dct_coeff,trdata_raw,trclass)
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
knn = zeros(1,nsubjects*5);             % to store the ordered knn's from least to greatest
for i = 1:nsubjects*5;
    L2_distance_vector = zeros(1,nsubjects*5);
    for j = 1:(nsubjects*5);
        subtract_vector = unknownFaces(i,:) - trdata_raw(j,:);
        % Take the norm and store in L2_distance
        L2_distance_vector(j) = norm(subtract_vector);
    end
    % Sort L2 vector
    [L2_ordered,L2_index] = sort(L2_distance_vector);

    % Find smallest k-distance and record labels of each candidate
    L2_class = L2_index(1:k);                   % stores the class label for each subject
    for m = 1:k
        L2_class(m) = trclass(L2_index(m));     % record the class of each k neighbor
    end

    %**************************************************************************
    % TAKE POPULARITY VOTE
    %**************************************************************************
    for m = 1:k
        L2_class_popularity(m) = length(find(L2_class==L2_class(m)));
            % The amount of time each subject occurs in the KNN
    end
    id_vector(i) = L2_class(find(L2_class_popularity==max(L2_class_popularity),1));
end

id_vector = id_vector'; 
end
