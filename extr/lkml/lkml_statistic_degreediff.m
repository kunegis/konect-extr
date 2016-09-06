
% Average indegree - outdegree

function value = lkml_statistic_degreediff(n, T, j)

    d_out = sparse(T(:,1), 1, 1, n, 1);
    d_in  = sparse(T(:,2), 1, 1, n, 1);
    d_j = d_in(j) - d_out(j);
    value = mean(d_j); 
