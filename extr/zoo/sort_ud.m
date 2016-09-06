%# -*-octave-*-
%#
%# Sort result of eigs by descending absolute eigenvalues. 
%#

function [u, d] = sort_ud(u, d)

[dd, permut] = sort(-abs(diag(d)));
d_diag = diag(d);
d = diag(d_diag(permut));
u = u(:, permut);

