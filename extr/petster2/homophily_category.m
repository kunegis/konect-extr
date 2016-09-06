%
% PARAMETERS 
%	cat	(n*1) Category vector, contains numbers from 1 to k,
%		or 0/-1/NaN when the value is not known
%	T1,T2	(e*1) The edges; contains values from 1 to n
%
% RESULT 
%	r	Homophily value (from -1 to +1)
%	err	The error on it 
%
% MEMORY 
%	O(k^2)
%

function [r err] = homophily_category(cat, T1, T2)

assert(length(T1) == length(T2)); 

k = max(cat)
n = length(T1);

x = cat(T1);
y = cat(T2);

i = isfinite(x) & (x > 0) & isfinite(y) & (y > 0);

x = x(i);
y = y(i); 

E = sparse(x, y, 1, k, k);

E + E';

E = E ./ sum(sum(E));

sum_sq = sum(sum(E^2))

r = (trace(E) - sum_sq) / (1 - sum_sq)

d = sum(E);

sum_a2 = sum(d .^ 2)
sum_a3 = sum(d .^ 3)

err = (sum_a2 + sum_a2 ^ 2 - 2 * sum_a3) / (1 - sum_a2) / n
