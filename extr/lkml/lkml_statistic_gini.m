
% Gini coefficient within the group 

function value = lkml_statistic_gini(n, T, j)

d = sparse(T(:,2), 1, 1, n, 1);
d_j = d(j); 
value = konect_gini_direct(d_j)
