%
% Generate a rank-one network.
%
% By a rank-one network, we mean a network whose adjacency matrix is approximately
%
%         (1/2|E|)  d d^T
%
% In which |E| is the number of edges and d is the degree vector.  This
% type of graphs is similar to a scale-free graph, but does not arise
% from a preferential attachment process. 
%
% The vector d is sampled from a power-law distribution. 
%

addpath ../../matlab/

alpha = 2.5; % Power-law exponent

nt = getenv('SIZE');
densityt = getenv('DENSITY'); 
n = sscanf(nt, '%d'); 
density = sscanf(densityt, '%d'); 

d = (2 ^ (alpha - 1) * (1 - rand(n,1))) .^ (-1 / (alpha - 1));

d = d ./ mean(d) .* density;

OUT = fopen(sprintf('out.random-rankone-%s-%s', nt, densityt), 'w');

fprintf(OUT, '%% sym unweighted\n');

[k from to] = fromto(1, n, 100); 

for i = 1:k

  a = (1 / (2 * n)) * d(from(k):to(k)) * d';

  [x y z] = find(a); 
  x = x + (from(k) - 1);

  ii = find(x < y);
  x = x(ii);
  y = y(ii);
  z = z(ii); 

  [z p] = sort(-z); 
  wanted = (to(k) + 1 - from(k)) * density;
  p = p(1:wanted);
  x = x(p);
  y = y(p);

  fprintf(OUT, '%d\t%d\n', [y x]');
end

if fclose(OUT), error 'fclose'; end; 
