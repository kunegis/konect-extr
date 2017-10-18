%
% Make a graph drawing for the paper.  Based on
% konect/analysis/m/delaunay_plot.m 
%
% INPUT 
%	out.lqfb-temporal
%
% OUTPUT 
%	plot-lqfb/drawing.a.eps
% 

color_pos  = [ 0.6 1   0.6 ];
color_neg  = [ 1   0.9 0.9 ]; 
color_zero = [ 1   1   1   ];
color_dmin = [ 0.8 0.8 1   ];
color_dmax = [ 0   0   1   ];
dmin = 0;
dmax = 70;
marker_size_min = 5; 
marker_size_max = 30;
aspect_ratio = 4;

consts = konect_consts(); 

T = load('out.lqfb-temporal');
n = max(max(T(:,1:2)))

%
% Matrices
%

% Half-adjacency matrix (including deleted edges), used to compute
% the drawing positions
A = sparse(T(:,1), T(:,2), 1, n, n); 
A = A + A';
A = triu(A);
A = (A ~= 0);
assert(size(A,1) == n); 
assert(size(A,2) == n); 

% Indegree, i.e., number of received delegations
d = sparse(T(:,2), 1, 1, n, 1); 

% Positive edges at the end of the run, full adjacency matrix 
A_pos = sparse(T(:,1), T(:,2), T(:,3), n, n); 
A_pos = A_pos + A_pos';
A_pos = (A_pos > 0);
assert(size(A_pos,1) == n); 
assert(size(A_pos,2) == n); 

% Edges that have been removed at some point, full adjacency matrix 
i_neg = (T(:,3) < 0);
A_neg = sparse(T(i_neg, 1), T(i_neg, 2), 1, n, n);
A_neg = A_neg + A_neg';
A_neg = (A_neg ~= 0);
assert(size(A_neg,1) == n); 
assert(size(A_neg,2) == n); 

% Sort nodes by increasing indegree, for drawing order
[d_ii, ii] = sort(d);

%
% Original embedding
%

[U_l D_l V_l] = konect_decomposition_stoch1(A, 3, consts.SYM, ...
                                            consts.UNWEIGHTED); 

x = U_l(:,2);
y = U_l(:,3); 

assert(size(x,1) == n);
assert(size(y,1) == n);
assert(size(x,2) == 1);
assert(size(y,2) == 1);

U = [ x y ];

%
% Stochastic matrix of original graph
%

d = sum(A,2) + sum(A,1)';
d_inv = d .^ -1;
d_inv(isinf(d_inv)) = 0;
P = spdiags(d_inv, [0], n, n) * (A | A');

%
% Delaunay triangulation
%

xe = U(:,1) + rand(n,1) * 1e-5 * mean(U(:,1));
ye = U(:,2) + rand(n,1) * 1e-5 * mean(U(:,2));

tri = delaunay(xe, ye);

T_d = [ tri(:,[1 2]); tri(:,[1 3]); tri(:,[2 3])];

% Half-adjacency matrix of Delaunay triangulation 
A_d = sparse(T_d(:,1), T_d(:,2), 1, n, n);
A_d = (A_d ~= 0); 
A_d = (A_d | A_d');
A_d = triu(A_d); 

%
% Embedding of the Delaunay triangulation
%

[V D] = konect_decomposition_stoch1(A_d, 3, consts.SYM, consts.UNWEIGHTED);
V = V(:,2:3);

%
% Delaunay drawing
%

V(:,2) = 0.3 * V(:,2);

hold on;

gplot2(A_neg(ii,ii), V(ii,:), '-', 'LineWidth', 0.1, 'Color', color_neg);
gplot2(A_pos(ii,ii), V(ii,:), '-', 'LineWidth', 0.1, 'Color', color_pos);

for j = 1 : n
    i = ii(j); 
    d_i = d(i);
    if d_i > dmax,  d_i = dmax;  end
    if d_i < dmin,  d_i = dmin;  end
    color = color_dmax * (d_i - dmin) / (dmax - dmin) + ...
            color_dmin * (dmax - d_i) / (dmax - dmin);
    marker_size = marker_size_max * (d_i - dmin) / (dmax - dmin) + ...
        marker_size_min * (dmax - d_i) / (dmax - dmin);
    plot(V(i,1), V(i,2), '.', 'MarkerSize', marker_size, ...
         'Color', color); 
end

axis off tight; 

pbaspect([aspect_ratio 1 1]); 

konect_print('plot-lqfb/drawing.a.eps');
