%
% Plot degree distributions.
%
% INPUT 
%	dat-lkml/ent.lkml-reply-type
%	dat-lkml/degree-1 
%	dat-lkml/degree-2
%	dat-lkml/n
%
% OUTPUT 
%	plot-lkml/degree.a.eps
%

font_size_legend = 15; 

colors = lkml_colors(); 
%labels = lkml_labels(); 

n = load('dat-lkml/n')

typ = load('dat-lkml/ent.lkml-reply-type');
size_type = size(typ)
assert(length(typ) == n); 

k = max(typ)

d1 = load('dat-lkml/degree-1');
d2 = load('dat-lkml/degree-2'); 
assert(length(d1) == n);
assert(length(d2) == n);

d = d1 + d2;

ds = cell(k,1);
d1s = cell(k,1);
d2s = cell(k,1);

for i = 1 : k
    ds{i}  = d( find(typ == i));
    d1s{i} = d1(find(typ == i));
    d2s{i} = d2(find(typ == i));
end

%
% Total degree
%

hold on;

for i = 1 : k
    konect_power_law_plot(ds{i}, [], 0, colors{i}, 0, 1); 
end

%legend(labels, 'FontSize', font_size_legend);

axis([0.8 1e5 1e-5 1]);

set(gca, 'XTick', [1e0 1e1 1e2 1e3 1e4 1e5]); 
set(gca, 'XMinorTick', 'on'); 
set(gca, 'YTick', [1e-5 1e-4 1e-3 1e-2 1e-1 1e-0]); 
set(gca, 'YMinorTick', 'on'); 

xlabel('Total degree (d)');
ylabel('P(x \geq d)'); 

konect_print('plot-lkml/degree.a.eps');

%
% Outdegree
%

hold on;

for i = 1 : k
    konect_power_law_plot(d1s{i}, [], 0, colors{i}, 0, 1); 
end

%legend(labels, 'FontSize', font_size_legend);

axis([0.8 1e5 1e-5 1]);

set(gca, 'XTick', [1e0 1e1 1e2 1e3 1e4 1e5]); 
set(gca, 'XMinorTick', 'on'); 
set(gca, 'YTick', [1e-5 1e-4 1e-3 1e-2 1e-1 1e-0]); 
set(gca, 'YMinorTick', 'on'); 

xlabel('Number of replies written (d^+)');
ylabel('P(x \geq d^+)'); 

konect_print('plot-lkml/degree.u.eps');

%
% Indegree
%

hold on;

for i = 1 : k
    konect_power_law_plot(d2s{i}, [], 0, colors{i}, 0, 1); 
end

%legend(labels, 'FontSize', font_size_legend);

axis([0.8 1e5 1e-5 1]);

set(gca, 'XTick', [1e0 1e1 1e2 1e3 1e4 1e5]); 
set(gca, 'XMinorTick', 'on'); 
set(gca, 'YTick', [1e-5 1e-4 1e-3 1e-2 1e-1 1e-0]); 
set(gca, 'YMinorTick', 'on'); 

xlabel('Number of replies received (d^-)');
ylabel('P(x \geq d^-)'); 

konect_print('plot-lkml/degree.v.eps');
