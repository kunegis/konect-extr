%
% Compute indegree.
%
% INPUT 
%	dat-lkml/out.lkml-reply
%	dat-lkml/n
%
% OUTPUT 
%	dat-lkml/feature.indegree
%

T = load('dat-lkml/out.lkml-reply');

n = load('dat-lkml/n'); 

indegree = sparse(T(:,2), 1, 1, n, 1); 

indegree = full(indegree); 

OUT = fopen('dat-lkml/feature.indegree', 'w');
if OUT < 0,  error();  end
fprintf(OUT, '%u\n', indegree');
if fclose(OUT) < 0,  error();  end
