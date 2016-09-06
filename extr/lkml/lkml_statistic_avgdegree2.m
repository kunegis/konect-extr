
% Average indegree 

function value = lkml_statistic_avgdegree2(n, T, j)

d = sparse(T(:,2), 1, 1, n, 1);
d_j = d(j); 
value = mean(d_j) 
