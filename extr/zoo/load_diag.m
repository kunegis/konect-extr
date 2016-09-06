% -*-octave-*-
%
% Load last last eigenvalue diagonal from logfile.
%
% Used for cases where eigs() returns a zero matrix. 
%

function [d] = load_diag() 

! ./save_diag

d = load('/tmp/save_diag');

