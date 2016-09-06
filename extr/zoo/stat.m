% -*-octave-*-
% Perform statistics.
%
% Environment variables:
%
% TMP_BASE     basename of tmpfiles.
% CmdrTaco     userid of CmdrTaco. 
%

%### Parameters
enable_distance = 0;
enable_laplacian = 1;

nn = 6;   % show the top N users
k = 20;  % reduced dimension.  (only used for distances)
opts.maxit= 100;
opts_l.maxit = 600;

CmdrTaco = str2num(getenv('CmdrTaco'));

file = fopen(strcat(getenv('TMP_BASE'), '.tmp'), 'w');

a3 = load('out.matrix');
a = spconvert(a3);

%### General Info
[link_count, tmp] = size(a3);
[n, ur] = size(a);
n = max(n, ur);
a(n, n)= 0; % no problem because on diagonal

%# left/right normalized
a_dls = spdiags(1 ./ (abs(a) * ones(n, 1)), [0], n, n) * a;
a_drs = a * spdiags(1 ./ (ones(1, n) * abs(a))', [0], n, n);

%# global stuff
sparsity = link_count / (n ^ 2);
mean_total = link_count / n;
[link_count_positive, tmp] = size(find (a3(:, 3) > 0));
[link_count_negative, tmp] = size(find (a3(:, 3) < 0));
mean_positive = link_count_positive / n;
mean_negative = link_count_negative / n;

fprintf(file, 'Users:  %d\n', n);
fprintf(file, 'Links:  %d\n', link_count);
fprintf(file, 'Positive links:  %d\n', link_count_positive);
fprintf(file, 'Negative links:  %d\n', link_count_negative);
fprintf(file, 'Sparsity:  %g\n', sparsity);
fprintf(file, 'Mean outlink:  %g\n', mean_total);
fprintf(file, 'Mean friend/fan count:  %g\n', mean_positive); 
fprintf(file, 'Mean foe/freak count:  %g\n', mean_negative); 

%# only positive and negative links
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


%# Relation counts per user
count_friends    = a_pos * ones(n, 1);
count_foes       = a_neg * ones(n, 1);
count_fans       = (ones(1, n) * a_pos)';
count_freaks     = (ones(1, n) * a_neg)';
count_total = count_friends + count_foes + count_fans + count_freaks; 

%# Top degrees
[top_total_counts , top_total_userids ] = sort(count_total  );
[top_friend_counts, top_friend_userids] = sort(count_friends);
[top_foe_counts   , top_foe_userids   ] = sort(count_foes   );
[top_fan_counts   , top_fan_userids   ] = sort(count_fans   );
[top_freak_counts , top_freak_userids ] = sort(count_freaks );

%# Median counts 
median_count_total   = top_total_counts (round(n / 2));
median_count_friends = top_friend_counts(round(n / 2));
median_count_foes    = top_foe_counts   (round(n / 2));
median_count_fans    = top_fan_counts   (round(n / 2));
median_count_freaks  = top_friend_counts(round(n / 2));

fprintf(file, 'Median links:  %d\n', median_count_total);
fprintf(file, 'Median friend count:  %d\n', median_count_friends);
fprintf(file, 'Median foe count:  %d\n', median_count_foes);
fprintf(file, 'Median fans count:  %d\n', median_count_fans);
fprintf(file, 'Median freaks count:  %d\n', median_count_freaks);


%# Co-relation chart
a_double = a + a_pos;
a_corr = a_double + a_double';
corr_pp = size(find(a_corr == +4), 1);
corr_pn = size(find(a_corr == +2), 1);
corr_nn = size(find(a_corr == -1), 1);
fprintf(file, 'Co-relations:  PP = %d, PN = %d, NN = %d\n', corr_pp, corr_pn, corr_nn); 


%# Friend-of-a-friend chart
frf_pp = a_pos * a_pos;
frf_pn = a_pos * a_neg;
frf_np = a_neg * a_pos; 
frf_nn = a_neg * a_neg;
frf_count_ppp = sum(full(sum(frf_pp .* a_pos)));
frf_count_ppn = sum(full(sum(frf_pp .* a_neg)));
frf_count_pnp = sum(full(sum(frf_pn .* a_pos)));
frf_count_pnn = sum(full(sum(frf_pn .* a_neg)));
frf_count_npp = sum(full(sum(frf_np .* a_pos)));
frf_count_npn = sum(full(sum(frf_np .* a_neg)));
frf_count_nnp = sum(full(sum(frf_nn .* a_pos)));
frf_count_nnn = sum(full(sum(frf_nn .* a_neg)));
fprintf(file, 'Friend-of-a-friend charts:  PP→P: %d, PP→N: %d, PN→P: %d, PN→N: %d\n', frf_count_ppp, frf_count_ppn, frf_count_pnp, frf_count_pnn);
fprintf(file, 'Friend-of-a-friend charts:  NP→P: %d, NP→N: %d, NN→P: %d, NN→N: %d\n', frf_count_npp, frf_count_npn, frf_count_nnp, frf_count_nnn);


%### Distances

if enable_distance == 1

%# Local
dist_common_children = full((a(CmdrTaco, :) * a')');
[near_counts_common_children, near_userids_common_children] = sort(dist_common_children);
fprintf(file, 'Nearest by common children:\n');
fprintf(file, '#%d:  %d\n', [near_userids_common_children((end-0):-1:(end-nn+1))'; near_counts_common_children((end-0):-1:(end-nn+1))']);

dist_common_parents = full(a' * a(:, CmdrTaco));
[near_counts_common_parents, near_userids_common_parents] = sort(dist_common_parents);
fprintf(file, 'Nearest by common parents:\n');
fprintf(file, '#%d:  %d\n', [near_userids_common_parents((end-0):-1:(end-nn+1))'; near_counts_common_parents((end-0):-1:(end-nn+1))']);

dist_common_children_reg = full((a_dls(CmdrTaco, :) * a_dls')');
[near_counts_common_children_reg, near_userids_common_children_reg] = sort(dist_common_children_reg);
fprintf(file, 'Nearest by common children regularized:\n');
fprintf(file, '#%d:  %g\n', [near_userids_common_children_reg((end-0):-1:(end-nn+1))'; near_counts_common_children_reg((end-0):-1:(end-nn+1))']);

dist_common_parents_reg = full(a_drs' * a_drs(:, CmdrTaco));
[near_counts_common_parents_reg, near_userids_common_parents_reg] = sort(dist_common_parents_reg);
fprintf(file, 'Nearest by common parents regularized:\n');
fprintf(file, '#%d:  %g\n', [near_userids_common_parents_reg((end-0):-1:(end-nn+1))'; near_counts_common_parents_reg((end-0):-1:(end-nn+1))']);

%## Spectral

%# exponential symmetric

[q_a_sym, d_a_sym] = eigs(a_sym, k, 'la', opts);
dist_exp_a_sym = (q_a_sym(CmdrTaco, :) * diag(exp(diag(d_a_sym))) * q_a_sym')';
[near_counts_exp_a_sym, near_userids_exp_a_sym] = sort(dist_exp_a_sym);
fprintf(file, 'Nearest by symmetric exponential:\n');
fprintf(file, '#%d:  %g\n', [near_userids_exp_a_sym((end-0):-1:(end-nn+1))'; near_counts_exp_a_sym((end-0):-1:(end-nn+1))']);

[q_a_dls_sym, d_a_dls_sym] = eigs(a_dls_sym, k, 'la', opts);
dist_exp_a_dls_sym = (q_a_dls_sym(CmdrTaco, :) * diag(exp(diag(d_a_dls_sym))) * q_a_dls_sym')';
[near_counts_exp_a_dls_sym, near_userids_exp_a_dls_sym] = sort(dist_exp_a_dls_sym)
fprintf(file, 'Nearest by symmetric exponential left regularized:\n');
fprintf(file, '#%d:  %g\n', [near_userids_exp_a_dls_sym((end-0):-1:(end-nn+1))'; near_counts_exp_a_dls_sym((end-0):-1:(end-nn+1))']);

[q_a_drs_sym, d_a_drs_sym] = eigs(a_drs_sym, k, 'la', opts);
dist_exp_a_drs_sym = (q_a_drs_sym(CmdrTaco, :) * diag(exp(diag(d_a_drs_sym))) * q_a_drs_sym')';
[near_counts_exp_a_drs_sym, near_userids_exp_a_drs_sym] = sort(dist_exp_a_drs_sym);
fprintf(file, 'Nearest by symmetric exponential right regularized:\n');
fprintf(file, '#%d:  %g\n', [near_userids_exp_a_drs_sym((end-0):-1:(end-nn+1))'; near_counts_exp_a_drs_sym((end-0):-1:(end-nn+1))']);

end;

%# Laplacian
if enable_laplacian == 1
	if enable_distance == 1
	  k_laplacian = 1 + k;
	else
	  k_laplacian = 3;
	end;

	[q_ls_sym, d_ls_sym] = eigs(ls_sym, k_laplacian, 'sa', opts_l);
	q_ls_sym(1:20, :)
	d_ls_sym

	if enable_distance == 1
	dist_ls_sym = (q_ls_sym(CmdrTaco, :) * pinv(d_ls_sym) * q_ls_sym')';
	[near_counts_ls_sym, near_userids_ls_sym] = sort(dist_ls_sym);
	fprintf(file, 'Nearest by Laplacian signed:\n');
	fprintf(file, '#%d:  %g\n', [near_userids_ls_sym((end-0):-1:(end-nn+1))'; near_counts_ls_sym((end-0):-1:(end-nn+1))']);
	end;
end; 



fclose(file); 


