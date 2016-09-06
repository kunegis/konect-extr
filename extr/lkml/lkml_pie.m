%
% Draw pie chart of use type distribution.
%
% INPUT 
%	dat-lkml/ent.lkml-reply-type
%
% OUTPUT 
%	plot-lkml/pie.a.eps
%

typ = load('dat-lkml/ent.lkml-reply-type');

typ = typ(find(typ > 0));

count = sparse(typ, 1, 1)

count_percent = 100 * count ./ sum(count) 

labels = lkml_labels(); 
colors = lkml_colors(); 

h = pie(count, labels);

hp = findobj(h, 'Type', 'patch');

for i = 1 : length(colors)
    color = colors{i}
    set(hp(i), 'FaceColor', color);
end

konect_print('plot-lkml/pie.a.eps');
