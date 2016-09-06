% -*-octave-*-
%
% Evaluate link sign prediction accuracy.
%
% Error measure is mean sign value (from -1 to +1).
%

function [] = pred()

ENABLE_BASIC = 		0;
ENABLE_CONNECT = 	0;
ENABLE_CONNECT2 = 	0;
ENABLE_NULL =           1;
ENABLE_SNORM = 		0;
ENABLE_L_SYM =		0;
ENABLE_LS_SYM =		1;
ENABLE_LS =		0;

file = fopen(strcat(getenv('TMP_BASE'), '.tmp'), 'w');

[k_max, k_max_sa, opts, opts_sa] = set_sparam(); 
%[a3_training, a, a3_test, n] = load_data();
decomp = load('out.decomp.mat');
a = decomp.a;
n = decomp.n;
a3_training = decomp.a3_training;
a3_test = decomp.a3_test;

%diag(decomp.d_ls_sym)'
%decomp.u_ls_sym(1:30,:)

%#### Generate matrices
a_sym = a + a';


%#### sum and products
if ENABLE_BASIC
  eval_basic(file, a3_test);
  pred_sparse(file, a3_test, 'a_square', a * a);
  pred_sparse(file, a3_test, 'a_sym', a_sym);
  pred_sparse(file, a3_test, 'a_sym_square', a_sym + a_sym * a);
  pred_sparse(file, a3_test, 'a_sym_square2', a_sym + a * a_sym);
  pred_sparse(file, a3_test, 'a_sym_square3', a_sym + a_sym * a_sym);
end


%#### ls sym
if ENABLE_LS_SYM
  '====== LS SYM ======='
  u = decomp.u_ls_sym;
  d = decomp.d_ls_sym;
%  u = u(:, 1:end);
  1/d(1,1)
  diag(d)'
  u(1:50,:)
  pred_full(file, a3_test, 'ls_sym', u, d * u', 0);
end



%##### snorm
'=========== SNORM ================'
degree = sum(abs(a) + abs(a'))';
[a] = connect(a3_training, a);
a_sym = a + a';
degree = sum(abs(a) + abs(a'))';
degree = degree .^ -.5;
dsi = spdiags(degree, [0], n, n); 
a_norm = dsi * a * dsi;
a_sym_norm = a_norm + a_norm';
%opts.tol = 1e-50;
opts.tol = 1e-60;
%opts.maxit = 100;
%opts.maxit = 31;
k_max2 = 2 * k_max;
[u, d] = eigs(a_sym_norm, k_max2, 'la', opts);
if 0
  d_new = diag(flipud(load_diag()));  
  diag(d)'
  d = d_new;
end
diag(d)'
%u(1:50,:)
%u = decomp.u_sym_snorm;
%d = decomp.d_sym_snorm;
pred_full(file, a3_test, 'a_sym_snorm', u, u', 0);
ddinv = sqrt(pinv(eye(k_max2) - d));  
pred_full(file, a3_test, 'l_sym_snorm', u * ddinv, ddinv * u', 0);





%#### a  
if ENABLE_NULL
  [u, d, v] = svds(a, k_max, 'L', opts);  
  %diag(d)
  pred_full(file, a3_test, 'a', u, d * v', 0);
  pred_full(file, a3_test, 'a_e', u, d * v', 10^(-10/3));
  pred_full(file, a3_test, 'a_exp', u, diag(exp(10^-(10/10) * diag(d))) * v', 0);
  pred_full(file, a3_test, 'a_exp_e', u, diag(exp(10^-(10/10) * diag(d))) * v', 10^(-21/5));
end

%#### a sym 
[u, d] = eigs(a_sym, k_max, 'la', opts);
diag(d)'
u(1:50,:)
pred_full(file, a3_test, 'a_sym', u, d * u', 0);
%pred_full(file, a3_test, 'a_sym_e', u, d * u', 10^(-17/4));
pred_full(file, a3_test, 'a_sym_exp', u, diag(exp(10^(-27/20) * diag(d))) * u', 0);
%pred_full(file, a3_test, 'a_sym_exp_e', u, diag(exp(10^(-27/20) * diag(d))) * u', 10^(-91/20));

%#### ls

if ENABLE_LS
  ls = spdiags(sum(abs(a), 1)', [0], n, n) - a;
%  opts_sa.maxit= 15;
  [u, d] = eigs(ls + speye(n), k_max_sa, 0, opts_sa);
  diag(d)
  d = d - eye(k_max_sa); 
  diag(d)
  d = pinv(d);
  diag(d)
  pred_full(file, a3_test, 'ls', u, d * u', 0);
end

%#### l sym				
% too bad
if ENABLE_L_SYM
  l_sym = spdiags(sum(a_sym, 1)', [0], n, n) - a_sym;
  [u, d] = eigs(l_sym, 1 + k_max_sa, 'sa', opts_sa); 
  d = diag(load_diag());
  u(1:20, 1:7)
%  diag(d)
  u = u(:, 1:end-1);
  d = inv(d(1:end-1, 1:end-1));
%  diag(d)
  pred_full(file, a3_test, 'l_sym', u, u', 0);
end
				
fclose(file); 
