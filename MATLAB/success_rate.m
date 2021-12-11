%**************************************************************************
% A function to identify the success rate of the KNN classifier.
% Inputs:
%   id_vector = a vector containing the facial identification of the
%       subjects done by the system
% Outputs:
%   y = the percentage of correct facial identification.
%**************************************************************************
function y = success_rate(id_vector)
nsubjects = 40;
total_faces_tested = 200;
score = 0;
correct_id = 1;
%**************************************************************************
% COUNT POINTS
%**************************************************************************
for i = 1:nsubjects
    for j = 1:5
        if id_vector((i-1)*5+j) == correct_id
            score = score + 1;
        end
    end
    correct_id = correct_id + 1;
end

%**************************************************************************
% COMPUTE SUCCESS RATE
%**************************************************************************
percent_correct = score/total_faces_tested;
y = percent_correct;
end