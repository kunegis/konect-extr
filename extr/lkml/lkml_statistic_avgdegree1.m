
% Average outdegree 

function value = lkml_statistic_avgdegree1(n, T, j)

d = sparse(T(:,1), 1, 1, n, 1);
d_j = d(j); 
value = mean(d_j) 
