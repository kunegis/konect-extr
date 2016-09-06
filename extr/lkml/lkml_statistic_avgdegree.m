
% Average degree

function value = lkml_statistic_avgdegree(n, T, j)

d = sparse([T(:,1) ; T(:,2)], 1, 1, n, 1);
d_j = d(j); 
value = mean(d_j) 
