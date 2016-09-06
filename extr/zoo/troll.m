% -*-octave-*-
%
% Evaluate troll prediction.
%
% Predict the "bottom" users using several centrality/trust measures, and compare that to the actual profanity list. 
%
% INPUT
%	out.matrix.clean   The rating matrix without any reference to Profanity+Blacklist
%	out.trolls         List of trolls
%

opts.maxit= 100;
opts_l.maxit = 100;

file = fopen(strcat(getenv('TMP_BASE'), '.tmp'), 'w');

set(0,'defaultaxesfontsize',20);

a3 = load('out.matrix.clean');
a = spconvert(a3);
[n, ur] = size(a);
n = max(n, ur);
a(n, n)= 0; % no problem because on diagonal

ti = load('out.trolls');
trolls = zeros(n, 1);
trolls(ti) = 1;

%
fprintf(file, 'Random predictor:  %f%%\n', 100 * size(ti,1)/n);

%# Preparation
a_pos = spconvert(a3(find (a3(:, 3) > 0), :));
a_neg = abs(spconvert(a3(find (a3(:, 3) < 0), :)));
a_pos(n, n) = 0;  % no problem because the diagonal is zero
a_neg(n, n) = 0;  
a_dls = spdiags(1 ./ (abs(a) * ones(n, 1)), [0], n, n) * a;
a_drs = a * spdiags(1 ./ (ones(1, n) * abs(a))', [0], n, n);
a_sym = a + a';
a_dls_sym = a_dls + a_dls';
a_drs_sym = a_drs + a_drs';
ls_sym = spdiags(abs(a_sym) * ones(n, 1), [0], n, n) - a_sym;
a_abs = abs(a);
a_abs_dl = spdiags(1 ./ max(1, (a_abs * ones(n, 1))), [0], n, n) * a_abs;
a_abs_dr = a_abs * spdiags(1 ./ (ones(1, n) * a_abs)', [0], n, n);
a_abs_sym = a_abs + a_abs';
a_abs_dl_sym = a_abs_dl + a_abs_dl';
a_abs_dr_sym = a_abs_dr + a_abs_dr';
l_abs_sym = spdiags(full(sum(a_abs_sym))', [0], n, n) - a_abs_sym;

%# Counts 
count_friends    = a_pos * ones(n, 1);
count_foes       = a_neg * ones(n, 1);
count_fans       = (ones(1, n) * a_pos)';
count_freaks     = (ones(1, n) * a_neg)';
count_total = count_friends + count_foes + count_fans + count_freaks; 
count_in = count_fans - count_freaks;
count_out = count_friends - count_foes;

troll_eval(file, trolls, 'freaks', -count_freaks);

troll_eval(file, trolls, 'in', count_in);
%troll_eval(file, trolls, 'out', count_out);

%# S
%f = .095
%for f = .05:.005:.15
%%   az = [a (f * ones(n,1)); ones(1,n) 0];
%%   [q_ag1, d_ag1] = eigs(az, 1, 'lm', opts);
%%   troll_eval(file, trolls, sprintf('S_%f', f), -q_ag1(1:n));
%end;				

%% az = [a (.095 * ones(n,1)); ones(1,n) 0];
%% [q_ag1, d_ag1] = eigs(az, 1, 'lm', opts);
%% troll_eval(file, trolls, sprintf('Sz', f), -q_ag1(1:n));

%% [q_av, d_av, k_av] = svds(a, 1, 'L', opts);
%% troll_eval(file, trolls, 'Sv', -q_av);

%# SL/SR
%% f = .2;
%% z_a_dls = [((1-f) * a_dls) (f * ones(n,1)); (ones(1,n)/n) 0];
%% [q_z_a_dls, d_z_a_dls] = eigs(z_a_dls, 1, 'lm', opts);
%% troll_eval(file, trolls, 'SLz', q_z_a_dls(1:n));


%% [q_a_dls, d_a_dls] = eigs(a_dls, 1, 'lm', opts);
%% [q_a_drs, d_a_drs] = eigs(a_drs, 1, 'lm', opts);
%% troll_eval(file, trolls, 'SL', q_a_dls);
%% troll_eval(file, trolls, 'SR', q_a_drs);



%# ST
[q_at, d_at] = eigs(a', 1, 'lm', opts);
troll_eval(file, trolls, 'ST', q_at);

%% for f = .01:.05:2
%% z_at = [(a') (f * ones(n,1)); ones(1,n) 0];
%% [z_q_at, z_d_at] = eigs(z_at, 1, 'lm', opts);
%% troll_eval(file, trolls, sprintf('STz_%f', f), z_q_at(1:n));
%% end;

%# STL/STR
%% [q_at_dls, d_at_dls] = eigs(a_dls', 1, 'lm', opts);
%% troll_eval(file, trolls, 'STL', q_at_dls);
%% [q_at_drs, d_at_drs] = eigs(a_drs', 1, 'lm', opts);
%% troll_eval(file, trolls, 'STR', q_at_drs);

%# SS
[q_a_sym, d_a_sym] = eigs(a_sym, 1, 'lm', opts);
troll_eval(file, trolls, 'SS', q_a_sym);

%# SSL/SSR
%[q_a_dls_sym, d_a_dls_sym] = eigs(a_dls_sym, 1, 'lm', opts);
%[q_a_drs_sym, d_a_drs_sym] = eigs(a_drs_sym, 1, 'lm', opts);
%troll_eval(file, trolls, 'SSL', -q_a_dls_sym);
%troll_eval(file, trolls, 'SSR', -q_a_drs_sym);

%# SP
%% [q_a_pos, d_a_pos] = eigs(a_pos + speye(n), 1, 'lm', opts);
%% troll_eval(file, trolls, 'SP', -q_a_pos);

%% %# SU
%% [q_a_abs, d_a_abs] = eigs(a_abs, 1, 'lm', opts);
%% troll_eval(file, trolls, 'SU', -q_a_abs);

%# STU
[q_at_abs, d_at_abs] = eigs(a_abs', 1, 'lm', opts);
troll_eval(file, trolls, 'STU', q_at_abs);

%% %# SSU
%% [q_a_abs_sym, d_a_abs_sym] = eigs(a_abs_sym, 1, 'lm', opts);
%% troll_eval(file, trolls, 'SSU', -q_a_abs_sym);
%% troll_eval(file, trolls, 'SSUy', - a' * q_a_abs_sym);

%% %# SSX
%% [q_ls_sym, d_ls_sym] = eigs(ls_sym, 2, 'sa', opts_l);
%% d_ls_sym
%% troll_eval(file, trolls, 'SSX1', -q_ls_sym(:,1));
%% troll_eval(file, trolls, 'SSX2', -q_ls_sym(:,2));

%% %# SSUX
%% [q_l_abs_sym, d_l_abs_sym] = eigs(l_abs_sym, 2, 'sa', opts_l);
%% d_l_abs_sym
%% troll_eval(file, trolls, 'SSUX1', -q_l_abs_sym(:,1));
%% troll_eval(file, trolls, 'SSUX2', -q_l_abs_sym(:,2));

%# PR - ST
prst = - (q_at_abs - (-q_at));
troll_eval(file, trolls, 'PRST', prst);

if 0
  rang = 0:.025:2;
  map = rang;
  for i = 1:size(rang,2)
    alpha = rang(i);
    prstA = (-q_at) - alpha * q_at_abs;
    [mm] = troll_eval(file, trolls, sprintf('prst_%f', alpha), prstA);
    map(i) = mm;
  end;
  plot(rang, map, 'LineWidth', 3);  
  xlabel('\beta (PageRank importance parameter)');
  ylabel('MAP (mean average precision)');
  print -depsc 'out.prst.eps'; close all; 
end;

nn=30;
[tops, top_userids] = sort(prst);
fprintf(file, '  XXXBottoms:\n');
fprintf(file, '#%d:  %g  %g\n', [top_userids(1:nn)'; tops(1:nn)'; q_at_abs(top_userids(1:nn))']);


if 0
X = [count_in (q_at_abs) (-q_at) (-q_a_sym) prst];

plotmatrix(X, X);
print -depsc 'out.trust.eps'; close all;
end;

if 1
set(0,'defaultaxesfontsize',14);
q_at = -q_at;
plot(q_at, q_at_abs, '.', q_at(ti), q_at_abs(ti), '.r');
axis([-0.006 +0.012 -0.001 +0.02]);  
xlabel('SR (Signed spectral ranking)');
ylabel('PR (PageRank)');
print -depsc 'out.v.eps'; close all;
end;

fclose(file); 

