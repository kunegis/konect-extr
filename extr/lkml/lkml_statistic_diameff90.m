
% In subgraph 

function value = lkml_statistic_diameff90(n, T, j)

consts = konect_consts(); 

jj = (j(T(:,1)) & j(T(:,2))); 
T_j = T(jj,:);
A_j = sparse(T_j(:,1), T_j(:,2), 1, n, n);

d = konect_hopdistr(A_j, consts.ASYM, [], 1);

value = konect_diameff(d, 0.9)


