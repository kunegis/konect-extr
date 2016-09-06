%
% Compute PageRank.
%
% INPUT 
%	dat-lkml/n
%	dat-lkml/out.lkml-reply
%
% OUTPUT 
%	dat-lkml/feature.pagerank
%

alpha = 0.2; 

n = load('dat-lkml/n');

T = load('dat-lkml/out.lkml-reply');
T = T(:,1:2);

A = sparse(T(:,1), T(:,2), 1, n, n); 

% 
% Compute PageRank
%

opts.disp = 2; 

pagerank = konect_pagerank(A, alpha, opts); 

assert(size(pagerank, 1) == n); 

save('dat-lkml/feature.pagerank', 'pagerank', '-ascii');
