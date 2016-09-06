%
% Plot outdegree vs indegree.
%
% INPUT 
%	dat-lkml/out.lkml-reply
%	dat-lkml/n
%
% OUTPUT 
%	plot-lkml/outin.a.eps
%

font_size = 22; 

T = load('dat-lkml/out.lkml-reply');
n = load('dat-lkml/n')

deg_out = sparse(T(:,1), 1, 1, n, 1);
deg_in  = sparse(T(:,2), 1, 1, n, 1);

loglog(deg_out, deg_in, 'o', 'Color', [0 0 0]);

xlabel('Number of replies written', 'FontSize', font_size);
ylabel('Number of replies received', 'FontSize', font_size);

set(gca, 'FontSize', font_size);

axis square;

ax = axis();
ax(1) = 0.7;
ax(3) = 0.7;
axis(ax); 

line(ax(1:2), ax(3:4), 'LineStyle', '--', 'Color', 0.5 * [1 1 1]); 

set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on'); 
set(gca, 'TickLength', [0.05 0.05]); 

% Workaround for Matlab bug. Otherwise, the minor ticks are not visible. 
ax = axis(); 
if ax(1) > 0 & ax(3) > 0 
    set(gca, 'XTick', 10 .^ (ceil(log(ax(1)) / log(10)):floor(log(ax(2)) / log(10)))); 
    set(gca, 'YTick', 10 .^ (ceil(log(ax(3)) / log(10)):floor(log(ax(4)) / log(10)))); 
end

konect_print('plot-lkml/outin.a.eps');


