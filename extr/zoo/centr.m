% -*-octave-*-
%
% Evaluate centrality/trust measures.
%

nn = 6;   % show the top N users
opts.maxit= 100;

file = fopen(strcat(getenv('TMP_BASE'), '.tmp'), 'w');

a3 = load('out.matrix');
a = spconvert(a3);

[n, ur] = size(a);
n = max(n, ur);
a(n, n)= 0; % no problem because on diagonal

%# left/right normalized
a_dls = spdiags(1 ./ (abs(a) * ones(n, 1)), [0], n, n) * a;
a_drs = a * spdiags(1 ./ (ones(1, n) * abs(a))', [0], n, n);

a_pos = spconvert(a3(find (a3(:, 3) > 0), :));
a_neg = abs(spconvert(a3(find (a3(:, 3) < 0), :)));
a_pos(n, n) = 0;  % no problem because the diagonal is zero
a_neg(n, n) = 0;  
a_pos_dls = spdiags(1 ./ max(1, (a_pos * ones(n, 1))), [0], n, n) * a_pos;
a_pos_drs = a_pos * spdiags(1 ./ (ones(1, n) * a_pos)', [0], n, n);

%# symmetric matrices
a_sym = a + a';
a_dls_sym = a_dls + a_dls';
a_drs_sym = a_drs + a_drs';
ls_sym = spdiags(abs(a_sym) * ones(n, 1), [0], n, n) - a_sym;

%# unsigned matrices
a_abs = abs(a);
a_abs_dl = spdiags(1 ./ max(1, (a_abs * ones(n, 1))), [0], n, n) * a_abs;
a_abs_dr = a_abs * spdiags(1 ./ (ones(1, n) * a_abs)', [0], n, n);

%# unsigned symmetric 
a_abs_sym = a_abs + a_abs';
a_abs_dl_sym = a_abs_dl + a_abs_dl';
a_abs_dr_sym = a_abs_dr + a_abs_dr';
l_abs_sym = spdiags(full(sum(a_abs_sym))', [0], n, n) - a_abs_sym;






%### Centrality/trust

%# Top by degrees
%# Relation counts per user
count_friends    = a_pos * ones(n, 1);
count_foes       = a_neg * ones(n, 1);
count_fans       = (ones(1, n) * a_pos)';
count_freaks     = (ones(1, n) * a_neg)';
count_total = count_friends + count_foes + count_fans + count_freaks; 
count_in = count_fans - count_freaks;
count_out = count_friends - count_foes;

[top_total_counts , top_total_userids ] = sort(count_total  );
[top_friend_counts, top_friend_userids] = sort(count_friends);
[top_foe_counts   , top_foe_userids   ] = sort(count_foes   );
[top_fan_counts   , top_fan_userids   ] = sort(count_fans   );
[top_freak_counts , top_freak_userids ] = sort(count_freaks );
[top_in_counts , top_in_userids ] = sort(count_in );
[top_out_counts , top_out_userids ] = sort(count_out );

fprintf(file, 'Top link count:\n');
fprintf(file, '#%d:  %d\n', [top_total_userids((end-0):-1:(end-nn+1))'; top_total_counts((end-0):-1:(end-nn+1))']);
fprintf(file, 'Top friend count:\n');
fprintf(file, '#%d:  %d\n', [top_friend_userids((end-0):-1:(end-nn+1))'; top_friend_counts((end-0):-1:(end-nn+1))']);
fprintf(file, 'Top foe count:\n');
fprintf(file, '#%d:  %d\n', [top_foe_userids((end-0):-1:(end-nn+1))'; top_foe_counts((end-0):-1:(end-nn+1))']);
fprintf(file, 'Top fan count:\n');
fprintf(file, '#%d:  %d\n', [top_fan_userids((end-0):-1:(end-nn+1))'; top_fan_counts((end-0):-1:(end-nn+1))']);
fprintf(file, 'Top freak count:\n');
fprintf(file, '#%d:  %d\n', [top_freak_userids((end-0):-1:(end-nn+1))'; top_freak_counts((end-0):-1:(end-nn+1))']);
fprintf(file, 'Top in count:\n');
fprintf(file, '#%d:  %d\n', [top_in_userids((end-0):-1:(end-nn+1))'; top_in_counts((end-0):-1:(end-nn+1))']);
fprintf(file, 'Top out count:\n');
fprintf(file, '#%d:  %d\n', [top_out_userids((end-0):-1:(end-nn+1))'; top_out_counts((end-0):-1:(end-nn+1))']);

%## Spectral

%# Assymetric 
[q_a, d_a] = eigs(a, 1, 'lm', opts);
[s_a, i_a] = sort(q_a);
fprintf(file, 'Spectral a top:\n');
fprintf(file, '#%d:  %g\n', [i_a((end-0):-1:(end-nn+1))'; s_a((end-0):-1:(end-nn+1))']);
fprintf(file, 'Spectral a bottom:\n');
fprintf(file, '#%d:  %g\n', [i_a(1:nn)'; s_a(1:nn)']);

%# Left-regularized
[q_a_dls, d_a_dls] = eigs(a_dls, 1, 'lm', opts);
[s_a_dls, i_a_dls] = sort(q_a_dls);
fprintf(file, 'Spectral a left regularized top:\n');
fprintf(file, '#%d:  %g\n', [i_a_dls((end-0):-1:(end-nn+1))'; s_a_dls((end-0):-1:(end-nn+1))']);
fprintf(file, 'Spectral a left regularized bottom:\n');
fprintf(file, '#%d:  %g\n', [i_a_dls(1:nn)'; s_a_dls(1:nn)']);

%# Right regularized
[q_a_drs, d_a_drs] = eigs(a_drs, 1, 'lm', opts);
[s_a_drs, i_a_drs] = sort(q_a_drs);
fprintf(file, 'Spectral a right regularized top:\n');
fprintf(file, '#%d:  %g\n', [i_a_drs((end-0):-1:(end-nn+1))'; s_a_drs((end-0):-1:(end-nn+1))']);
fprintf(file, 'Spectral a right regularized bottom:\n');
fprintf(file, '#%d:  %g\n', [i_a_drs(1:nn)'; s_a_drs(1:nn)']);

%# transposed 
[q_at, d_at] = eigs(a' + speye(n), 1, 'lm', opts);
[s_at, i_at] = sort(q_at);
fprintf(file, 'Spectral a transp top:\n');
fprintf(file, '#%d:  %g\n', [i_at((end-0):-1:(end-nn+1))'; s_at((end-0):-1:(end-nn+1))']);
fprintf(file, 'Spectral a transp bottom:\n');
fprintf(file, '#%d:  %g\n', [i_at(1:nn)'; s_at(1:nn)']);

%# Symmetric
[q_a_sym, d_a_sym] = eigs(a_sym, 1, 'lm', opts);
[s_a_sym, i_a_sym] = sort(q_a_sym); 
fprintf(file, 'Spectral a symmetric top:\n');
fprintf(file, '#%d:  %g\n', [i_a_sym((end-0):-1:(end-nn+1))'; s_a_sym((end-0):-1:(end-nn+1))']);
fprintf(file, 'Spectral a symmetric bottom:\n');
fprintf(file, '#%d:  %g\n', [i_a_sym(1:nn)'; s_a_sym(1:nn)']);

%# symmetric left regularized
[q_a_dls_sym, d_a_dls_sym] = eigs(a_dls_sym, 1, 'lm', opts);
[s_a_dls_sym, i_a_dls_sym] = sort(q_a_dls_sym); 
fprintf(file, 'Spectral a symmetric left regularized top:\n');
fprintf(file, '#%d:  %g\n', [i_a_dls_sym((end-0):-1:(end-nn+1))'; s_a_dls_sym((end-0):-1:(end-nn+1))']);
fprintf(file, 'Spectral a symmetric left regularized bottom:\n');
fprintf(file, '#%d:  %g\n', [i_a_dls_sym(1:nn)'; s_a_dls_sym(1:nn)']);

%# Symmetric right regularized
[q_a_drs_sym, d_a_drs_sym] = eigs(a_drs_sym, 1, 'lm', opts);
[s_a_drs_sym, i_a_drs_sym] = sort(q_a_drs_sym); 
fprintf(file, 'Spectral a symmetric right regularized top:\n');
fprintf(file, '#%d:  %g\n', [i_a_drs_sym((end-0):-1:(end-nn+1))'; s_a_drs_sym((end-0):-1:(end-nn+1))']);
fprintf(file, 'Spectral a symmetric right regularized bottom:\n');
fprintf(file, '#%d:  %g\n', [i_a_drs_sym(1:nn)'; s_a_drs_sym(1:nn)']);

%# Positive (PageRank, ignore negative links)
[q_a_pos, d_a_pos] = eigs(a_pos + speye(n), 1, 'lm', opts);
[s_a_pos, i_a_pos] = sort(q_a_pos); 
fprintf(file, 'Spectral a positive (PageRank) top:\n');
fprintf(file, '#%d:  %g\n', [i_a_pos((end-0):-1:(end-nn+1))'; s_a_pos((end-0):-1:(end-nn+1))']);
fprintf(file, 'Spectral a positive (PageRank) bottom:\n');
fprintf(file, '#%d:  %g\n', [i_a_pos(1:nn)'; s_a_pos(1:nn)']);

%% %# positive left regularized
%% [q_a_pos_regl, d_a_pos_regl] = eigs(a_pos_dls + speye(n), 1, 'lm', opts);
%% [s_a_pos_regl, i_a_pos_regl] = sort(q_a_pos_regl); 
%% fprintf(file, 'Spectral a positive left regularized top:\n');
%% fprintf(file, '#%d:  %g\n', [i_a_pos_regl((end-0):-1:(end-nn+1))'; s_a_pos_regl((end-0):-1:(end-nn+1))']);
%% fprintf(file, 'Spectral a positive left regularized bottom:\n');
%% fprintf(file, '#%d:  %g\n', [i_a_pos_regl(1:nn)'; s_a_pos_regl(1:nn)']);

%% %#positive right regularized
%% [q_a_pos_regr, d_a_pos_regr] = eigs(a_pos_drs + speye(n), 1, 'lm', opts);
%% [s_a_pos_regr, i_a_pos_regr] = sort(q_a_pos_regr); 
%% fprintf(file, 'Spectral a positive right regularized top:\n');
%% fprintf(file, '#%d:  %g\n', [i_a_pos_regr((end-0):-1:(end-nn+1))'; s_a_pos_regr((end-0):-1:(end-nn+1))']);
%% fprintf(file, 'Spectral a positive right regularized bottom:\n');
%% fprintf(file, '#%d:  %g\n', [i_a_pos_regr(1:nn)'; s_a_pos_regr(1:nn)']);
				
%# Unsigned ("importance")
[q_a_abs, d_a_abs] = eigs(a_abs, 1, 'lm', opts);
[s_a_abs, i_a_abs] = sort(q_a_abs);
fprintf(file, 'Spectral a unsigned top:\n');
fprintf(file, '#%d:  %g\n', [i_a_abs((end-0):-1:(end-nn+1))'; s_a_abs((end-0):-1:(end-nn+1))']);
fprintf(file, 'Spectral a unsigned bottom:\n');
fprintf(file, '#%d:  %g\n', [i_a_abs(1:nn)'; s_a_abs(1:nn)']);

%% %# unsigned left regularized
%% [q_a_abs_dl, d_a_abs_dl] = eigs(a_abs_dl, 1, 'lm', opts);
%% [s_a_abs_dl, i_a_abs_dl] = sort(q_a_abs_dl); 
%% fprintf(file, 'Spectral a unsigned left regularized top:\n');
%% fprintf(file, '#%d:  %g\n', [i_a_abs_dl((end-0):-1:(end-nn+1))'; s_a_abs_dl((end-0):-1:(end-nn+1))']);
%% fprintf(file, 'Spectral a unsigned left regularized bottom:\n');
%% fprintf(file, '#%d:  %g\n', [i_a_abs_dl(1:nn)'; s_a_abs_dl(1:nn)']);

%% %# unsigned right regularized
%% [q_a_abs_dr, d_a_abs_dr] = eigs(a_abs_dr, 1, 'lm', opts);
%% [s_a_abs_dr, i_a_abs_dr] = sort(q_a_abs_dr); 
%% fprintf(file, 'Spectral a unsigned right regularized top:\n');
%% fprintf(file, '#%d:  %g\n', [i_a_abs_dr((end-0):-1:(end-nn+1))'; s_a_abs_dr((end-0):-1:(end-nn+1))']);
%% fprintf(file, 'Spectral a unsigned right regularized bottom:\n');
%% fprintf(file, '#%d:  %g\n', [i_a_abs_dr(1:nn)'; s_a_abs_dr(1:nn)']);

%# Unsigned symmetric ("importance")
[q_a_abs_sym, d_a_abs_sym] = eigs(a_abs_sym, 1, 'lm', opts);
[s_a_abs_sym, i_a_abs_sym] = sort(q_a_abs_sym);
fprintf(file, 'Spectral a unsigned symmetric top:\n');
fprintf(file, '#%d:  %g\n', [i_a_abs_sym((end-0):-1:(end-nn+1))'; s_a_abs_sym((end-0):-1:(end-nn+1))']);
fprintf(file, 'Spectral a unsigned symmetric bottom:\n');
fprintf(file, '#%d:  %g\n', [i_a_abs_sym(1:nn)'; s_a_abs_sym(1:nn)']);

%% %# unsigned symmetric left regularized
%% [q_a_abs_dl_sym, d_a_abs_dl_sym] = eigs(a_abs_dl_sym, 1, 'lm', opts);
%% [s_a_abs_dl_sym, i_a_abs_dl_sym] = sort(q_a_abs_dl_sym); 
%% fprintf(file, 'Spectral a unsigned symmetric left regularized top:\n');
%% fprintf(file, '#%d:  %g\n', [i_a_abs_dl_sym((end-0):-1:(end-nn+1))'; s_a_abs_dl_sym((end-0):-1:(end-nn+1))']);
%% fprintf(file, 'Spectral a unsigned symmetric left regularized bottom:\n');
%% fprintf(file, '#%d:  %g\n', [i_a_abs_dl_sym(1:nn)'; s_a_abs_dl_sym(1:nn)']);

%% %# unsigned symmetric right regularized
%% [q_a_abs_dr_sym, d_a_abs_dr_sym] = eigs(a_abs_dr_sym, 1, 'lm', opts);
%% [s_a_abs_dr_sym, i_a_abs_dr_sym] = sort(q_a_abs_dr_sym); 
%% fprintf(file, 'Spectral a unsigned symmetric right regularized top:\n');
%% fprintf(file, '#%d:  %g\n', [i_a_abs_dr_sym((end-0):-1:(end-nn+1))'; s_a_abs_dr_sym((end-0):-1:(end-nn+1))']);
%% fprintf(file, 'Spectral a unsigned symmetric right regularized bottom:\n');
%% fprintf(file, '#%d:  %g\n', [i_a_abs_dr_sym(1:nn)'; s_a_abs_dr_sym(1:nn)']);


xx = [count_in count_out q_a];
xx(1:20,:)
plotmatrix(xx);  print -depsc 'out.centr_eval.eps'; close all;

fclose(file); 
