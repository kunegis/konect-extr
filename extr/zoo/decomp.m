% -*-octave-*-
%
% Compute and save matrix decompositions.
%
% INPUT
%	out.training
%
% OUTPUT
%	out.decomp.mat
%

function [] = decomp()

ENABLE_SNORM = 		0;

[k_max, k_max_sa, opts, opts_sa] = set_sparam(); 
[a3_training, a, a3_test, n] = load_data();

[a] = connect(a3_training, a);
a_sym = a + a';

%### SNORM
if ENABLE_SNORM
  degree = sum(abs(a) + abs(a'))';
  degree = sum(abs(a) + abs(a'))';
  degree = degree .^ -.5;
  dsi = spdiags(degree, [0], n, n); 
  a_norm = dsi * a * dsi;
  a_sym_norm = a_norm + a_norm';
  [u_sym_snorm, d_sym_snorm] = eigs(a_sym_norm, k_max, 'la', opts);
end

%### LS SYM
ls_sym = spdiags(sum(abs(a) + abs(a'), 1)', [0], n, n) - a_sym;
opts_sa.maxit = 9100;
[u, d] = eigs(10 * ls_sym, 1 + k_max_sa, 'sa', opts_sa);  
d_ls_sym2 = d;
d = diag(load_diag());  
'load_diag'
diag(d)'
'returned'
diag(d_ls_sym2)'
u_ls_sym = u;
d_ls_sym = pinv(diag(flipud(diag(d/10)))); 



%##save

save -v7.3 'out.decomp.mat'  u_ls_sym d_ls_sym a3_training a a3_test n;
%u_sym_snorm d_sym_snorm
