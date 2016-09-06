% -*-octave-*-
%
% Set the parameters for eigs and svds.
%
% k:  the number of dimensions
% opts:  the argument to svds and eigs
%
% _sa:  The variant when using the 'sa' mode of eigs/svds.
% 

function [k_max, k_max_sa, opts, opts_sa] = set_sparam()

ENABLE_FAST = 		0;

%#
%# Maximum reduced dimensions
%#

if ~ENABLE_FAST
  k_max = 	50;  
  k_max_sa = 	50; 
else
  k_max = 	20;
  k_max_sa = 	5;
end
				
%#
%# Iteration abortion 
%#

if ~ENABLE_FAST
%%   opts.maxit= 		99999; 
%   opts_sa.maxit= 	600; 
else				
  opts.maxit = 		10;
  opts_sa.maxit = 	10;
end

opts.disp=1;
opts_sa.disp=1;


