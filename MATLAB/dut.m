
unknown_face = findfeatures('att_faces\s8\1.pgm',dct_coef);
known_face = trdata_raw(36,:)';
subtract_vect = unknown_face - known_face;
L2_distance = norm(subtract_vect);

%%

z = [1 2 3 ; 4 5 6 ; 7 8 9]