% -*-octave-*-
%
% Calculate clustering coefficients
%


file = fopen(strcat(getenv('TMP_BASE'), '.tmp'), 'w');

a3 = load('out.matrix');
a = spconvert(a3);

%### General Info
[k, tmp] = size(a3);
[n, ur] = size(a);
n = max(n, ur);
a(n, n)= 0; % no problem because on diagonal

fprintf(file, 'Random clusco:  %f\n', k/n);
fprintf(file, 'Random clusco (directed):  %f\n', 2*k/n);

a_sym = a + a';
a_abs = abs(a);
a_abs_sym = a_abs + a_abs';

%# Clustering coefficient [228]
clusco_single(file, a_abs_sym, 'abs sym');
clusco_single(file, a_abs,     'abs');
clusco_single(file, a_sym,     'sym');
clusco_single(file, a,         'plain'); 

fclose(file); 
