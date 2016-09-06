
% Average PageRank

function value = lkml_statistic_avgpagerank(n, T, j)

A = sparse(T(:,1), T(:,2), 1, n, n);

u = konect_pagerank(A, 0.2); 

value = mean(u(j))
