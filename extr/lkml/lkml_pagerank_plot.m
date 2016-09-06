%
% Plot the PageRank distribution.
%
% INPUT 
%	dat-lkml/ent.lkml-reply-type
%	dat-lkml/feature.pagerank
%	dat-lkml/n
%
% OUTPUT 
%	plot-lkml/pagerank.a.eps
%

font_size_legend = 15; 

colors = lkml_colors(); 
%labels = lkml_labels(); 

n = load('dat-lkml/n'); 
p = load('dat-lkml/feature.pagerank'); 
typ = load('dat-lkml/ent.lkml-reply-type');

k = max(typ); 

assert(size(p,1) == n);
assert(size(typ,1) == n);

ps = cell(k, 1); 

for i = 1 : k
    ps{i} = p(find(typ == i)); 
end

hold on;

for i = 1 : k
    konect_power_law_plot(ps{i}, [], 0, colors{i}, 0, 1); 
end

%legend(labels, 'FontSize', font_size_legend);

set(gca, 'XMinorTick', 'on'); 
set(gca, 'YMinorTick', 'on'); 

xlabel('PageRank (p)');
ylabel('P(x \geq p)'); 

konect_print('plot-lkml/pagerank.a.eps');
