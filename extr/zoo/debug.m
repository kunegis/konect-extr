% -*-octave-*-

k = 3;

opts.disp=1;
opts.maxit = 600; 

a3 = load('out.matrix');
a = spconvert(a3);

[n, ur] = size(a);
n = max(n, ur);
a(n, n)= 0; % no problem because on diagonal


i = 2; j= 3; 

a_sym = a + a';
ls_sym = spdiags(abs(a_sym) * ones(n, 1), [0], n, n) - a_sym;

[q_ls_sym, d_ls_sym] = eigs(ls_sym, k, 'sa', opts);
q_ls_sym(1:20, :)
d_ls_sym

range = [-0.00003 0.00003 -0.00003 0.00003];
  		
plot(q_ls_sym(:, i), q_ls_sym(:, j), '.');  axis(range); print -depsc 'pca_ls_sym_dot.eps'; close all;
line(q_ls_sym(a3(:, [1, 2]), i)', q_ls_sym(a3(:, [1, 2]), j)'); axis(range); print -depsc 'pca_ls_sym_line.eps'; close all;	

plot(q_l_abs_sym(:, i), q_l_abs_sym(:, j), '.');  print -depsc 'pca_l_abs_sym_dot.eps'; close all;
line(q_l_abs_sym(a3(:, [1, 2]), i)', q_l_abs_sym(a3(:, [1, 2]), j)'); print -depsc 'pca_l_abs_sym_line.eps'; close all;
				
