% -*-octave-*-

function [] = eval_exp()

[a3_training, a, a3_test, n] = load_data();
[k_max, k_max_l, opts, opts_l] = set_sparam();

file = fopen(strcat(getenv('TMP_BASE'), '.tmp'), 'w');

eval_basic(file, a3_test);

a_sym = a + a';

[u, d] = eigs(a_sym, k_max, 'la', opts);  
d = diag(exp(10^(-27/20) * diag(d))); 

pred_full(file, a3_test, 'threshold_00', u, d * u', 10);
pred_full(file, a3_test, 'threshold_30', u, d * u',  0);

for threshold_exp = 1:20
  threshold = 10^-((threshold_exp -10)/20 + 9/2)
  pred_full(file, a3_test, sprintf('a_sym_exp_%02d', threshold_exp), ...
	    u, d * u', threshold);
end;


fclose(file); 
