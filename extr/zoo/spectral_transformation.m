% -*-octave-*-
%
% Evaluation for _Power Sum Graph Kernels_
%

file = fopen(strcat(getenv('TMP_BASE'), '.tmp'), 'w');

k = 300;

a = spconvert(load('out.training')); 
[n, nr] = size(a); n = max(n, nr); a(n, n)= 0; % no problem because on diagonal
a = a + a';
b = spconvert(load('out.test')); 
b(n,n) = 0;

[u,d] = eigs(a,k);
dd = diag(d);

ubu = u' * b * u;
g = diag(ubu);

plot(dd, g, '.-');  print -depsc 'out.power.eps';  close all;

fclose(file);


