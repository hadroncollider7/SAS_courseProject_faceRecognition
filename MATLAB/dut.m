
unknown_face = findfeatures('att_faces\s8\1.pgm',dct_coef);
known_face = trdata_raw(36,[1:dct_coef])';
subtract_vect = unknown_face - known_face;
L2_distance = norm(subtract_vect);
