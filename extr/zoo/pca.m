% -*-octave-*-
%
% Compute decompositions. 
%
% OUTPUT
%	plot/pca.a.[uv].eps
%	plot/pca.l.eps
%	plot/pca.m.eps
%
%	dat/decomp.mat		decompositions
%		n
%		u_a, d_a, v_a
%		u_l, d_l
%		u_m, d_m
%

k_a = 30;
k_l = 20; 

opts.disp = 2; 

file = fopen(strcat(getenv('TMP_BASE'), '.tmp'), 'w');

a3 = load('out.matrix');
a = spconvert(a3);

[link_count, tmp] = size(a3);
[n, ur] = size(a);
n = max(n, ur);
a(n, n)= 0; % no problem because on diagonal

  		
a_sym = a + a';
a_abs = abs(a);
a_abs_sym = a_abs + a_abs';

%
% (a) Adjacency matrix
%
[u_a, d_a, v_a] = svds(a, k_a, 'L', opts);
%plot(u_a(:,1), u_a(:,2), '.'); print -depsc 'plot/pca.a.u.eps'; close all;
%plot(v_a(:,1), v_a(:,2), '.'); print -depsc 'plot/pca.a.v.eps'; close all; 




%
% (l)  Laplacian
%

l = spdiags(sum(a_abs_sym)', [0], n, n) - a_sym;
epsilon = .001;
[u_l, d_l] = eigs(l, k_l, -epsilon, opts);
%u_l(1:20, :)
%diag(d_l)'

%plot(u_l(:, 1), u_l(:, 2), '.', 'MarkerSize', 1);  
%print -depsc 'plot/pca.l.eps'; close all;

%plot(q_ls_sym(:, j), q_ls_sym(:, k), '.', 'MarkerSize', 1);  
%print -depsc 'pca_ls_sym_dot2.eps'; close all;

%line(q_ls_sym(a3(:, [1, 2]), i)', q_ls_sym(a3(:, [1, 2]), j)', 'LineWidth', 0.2); 
%print -depsc 'pca_ls_sym_line.eps'; close all;	



%
% (m) unsigned Laplacian 
%
l_abs = spdiags(sum(a_abs_sym)', [0], n, n) - a_abs_sym;
[u_m, d_m] = eigs(l_abs, k_l, 'sa', opts);
%u_m(1:20, :)
%diag(d_m)'

%plot(u_m(:, 2), u_m(:, 3), '.', 'MarkerSize', 4);  
%axis(1e-4 * [-2 0 0 2]); 
%print -depsc 'plot/pca.m.eps'; close all;

%plot(q_l_abs_sym(:, j), q_l_abs_sym(:, k), '.', 'MarkerSize', 1);  
%axis(1e-4 * [0 2 -1.5 0.5]); 
%print -depsc 'pca_l_abs_sym_dot2.eps'; close all;

%line(q_l_abs_sym(a3(:, [1, 2]), i)', q_l_abs_sym(a3(:, [1, 2]), j)', 'LineWidth', 0.2); 
%axis(range); 
%print -depsc 'pca_l_abs_sym_line.eps'; close all;

save -v7.3 'dat/decomp.mat' n u_a d_a v_a u_l d_l u_m d_m; 
fclose(file); 
