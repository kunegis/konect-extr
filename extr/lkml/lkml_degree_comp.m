%
% Compute degree distributions.
%
% INPUT 
%	dat-lkml/out.lkml-reply
%	dat-lkml/n
%
% OUTPUT 
%	dat-lkml/degree-1	Outdegree
%	dat-lkml/degree-2	Indegree
%

n = load('dat-lkml/n')

T = load('dat-lkml/out.lkml-reply');
T = T(:,1:2);

d1 = full(sparse(T(:,1), 1, 1, n, 1));
d2 = full(sparse(T(:,2), 1, 1, n, 1));

assert(length(d1) == n);
assert(length(d2) == n);

OUT = fopen('dat-lkml/degree-1', 'w')
if OUT < 0,  error('fopen');  end;
fprintf(OUT, '%u\n', d1);
if fclose(OUT) < 0,  error('fclose');  end; 

OUT = fopen('dat-lkml/degree-2', 'w')
if OUT < 0,  error('fopen');  end;
fprintf(OUT, '%u\n', d2);
if fclose(OUT) < 0,  error('fclose');  end; 

