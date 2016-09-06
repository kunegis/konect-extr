% -*-octave-*-
%
% Scatter plots
%

file = fopen(strcat(getenv('TMP_BASE'), '.tmp'), 'w');

a3 = load('out.matrix');
a = spconvert(a3);

[link_count, tmp] = size(a3);
[n, ur] = size(a);
n = max(n, ur);
a(n, n)= 0; % no problem because on diagonal

a_abs = abs(a);
a_abs_sym = a_abs + a_abs';

a_pos = spconvert(a3(find (a3(:, 3) > 0), :));
a_neg = abs(spconvert(a3(find (a3(:, 3) < 0), :)));
a_pos(n, n) = 0;  % no problem because the diagonal is zero
a_neg(n, n) = 0;  

degree_total = a_abs_sym * ones(n, 1);
degree_out = a_abs * ones(n, 1);
degree_in = a_abs' * ones(n, 1);
%cl = clusco_single(file, a_abs_sym, 'plain');

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

set(0,'defaultaxesfontsize',20);

%# Scatter plots
plot(degree_out, degree_in, '.');  axis([0 450 0 600]); xlabel('out-degree');ylabel('in-degree');   print -depsc 'out.scatter_out_in_flat.eps';   close all; 
loglog(degree_out, degree_in, '.');  xlabel('out-degree');ylabel('in-degree');   print -depsc 'out.scatter_out_in.eps';  close all; 
%loglog(degree_total, cl, '.');       print -depsc 'out.scatter_total_cl.eps'; close all; 

%# Degree distributions
maxcount = top_total_counts(end-0);
freq_total = histc(top_total_counts, 0:maxcount);
freq_friends = histc(top_friend_counts, 0:maxcount);
freq_foes = histc(top_foe_counts, 0:maxcount);
freq_fans = histc(top_fan_counts, 0:maxcount);
freq_freaks = histc(top_freak_counts, 0:maxcount);


loglog(0:maxcount, freq_total, 'ob'); xlabel('total degree'); ylabel('frequency');   print -depsc 'freq_total.eps';  close all;


loglog(0:maxcount, freq_friends);  print -depsc 'freq_friends.eps';  close all;
loglog(0:maxcount, freq_foes); print -depsc 'freq_foes.eps'; close all;
loglog(0:maxcount, freq_fans); print -depsc 'freq_fans.eps'; close all;
loglog(0:maxcount, freq_freaks); print -depsc 'freq_freaks.eps'; close all;

%% cl_max = max(cl);
%% cl_max
%% cl_range = 0:(cl_max/13):cl_max;
%% freq_cl = hist(cl, cl_range);
%% freq_cl
%% semilogy(cl_range, freq_cl);  print -depsc 'freq_cl.eps'; close all;
				
fclose(file); 
