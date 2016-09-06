
% Average edge multiplicity between two nodes of the group 

function value = lkml_statistic_avgmultiplicity(n, T, j)

jj = (j(T(:,1)) & j(T(:,2))); 
T_j = T(jj,:);
A_j = sparse(T_j(:,1), T_j(:,2), 1, n, n);
[xx yy zz] = find(A_j);
value = mean(zz) 
