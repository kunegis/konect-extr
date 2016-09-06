% -*-octave-*-
% 
% Evaluate parameters of exponential kernels.
%


function [] = eval_exp()

[a3_training, a, a3_test, n] = load_data();
[k_max, k_max_l, opts, opts_l] = set_sparam();

%k_max_l = 35;

file = fopen(strcat(getenv('TMP_BASE'), '.tmp'), 'w');

a_sym = a + a';
ls_sym = spdiags(abs(a_sym) * ones(n, 1), [0], n, n) - a_sym;

[u, d] = eigs(ls_sym, 1 + k_max_l, 'sa', opts_l);  
d = diag(load_diag());
u = u(:, 1:end-1);
d = inv(diag(flipud(diag(d(1:end-1, 1:end-1))))); 
%pred_full(file, a3_test, 'ls_sym', u, d * u', 0);

for alpha = 1:20
  alpha_value = 10^-(4/10 + (alpha-10)/50);
  pred_full(file, a3_test, sprintf('ls_sym_exp_%02d', alpha), ...
	    u, diag(exp(alpha_value * diag(d))) * u', 0);
end;


fclose(file); 
