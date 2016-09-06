% -*-octave-*-
% 
% Evaluate the maxit parameter of svds/eigs.
%
%


function [] = eval_exp()

[a3_training, a, a3_test, n] = load_data();
[k_max, k_max_l, opts, opts_l] = set_sparam();

opts.disp=1;

file = fopen(strcat(getenv('TMP_BASE'), '.tmp'), 'w');

eval_basic(file, a3_test);

a_sym = a + a';
ls_sym = spdiags(abs(a_sym) * ones(n, 1), [0], n, n) - a_sym;

for maxit = 1:1:400

  opts_l.maxit = maxit;

  [u, d] = eigs(ls_sym, 1 + k_max_l, 'sa', opts_l);  
  d = diag(load_diag());
  u = u(:, 1:end-1);
  d = inv(diag(flipud(diag(d(1:end-1, 1:end-1))))); 


  pred_full(file, a3_test, sprintf('ls_sym_%02d', maxit), u, d * u', 0);
%  pred_full(file, a3_test, sprintf('maxit_%d', maxit), u, d * u', 0);
end;


fclose(file); 
