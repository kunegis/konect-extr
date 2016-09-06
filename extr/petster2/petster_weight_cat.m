%
% Plot weight distribution of cats. 
%
% INPUT 
%	dat-petster/weight.cat
%
% OUTPUT 
%	plot-petster/weight.a.cat.eps
%

font_size = 22;

colors = petster_colors(); 

% First column is frequency; second column is weight in pounds
data = load('dat-petster/weight.cat');

freq = data(:,1);
weight_kg = data(:,2) * 0.45359237; 

bar(weight_kg, freq, 1, ...
    'FaceColor', colors.cat); 

xlabel('Cat weight [kg]', 'FontSize', font_size); 
ylabel('Density [cats / kg]', 'FontSize', font_size); 

set(gca, 'FontSize', font_size); 

axis([0 20 0 15000]);

pbaspect([3 1 1]);

konect_print('plot-petster/weight.a.cat.eps');
