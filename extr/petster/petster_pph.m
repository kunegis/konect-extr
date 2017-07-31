%
% Plot distribution of pets per household. 
%
% INPUT 
%	dat-petster/household.hamster
%	dat-petster/household.cat
%	dat-petster/household.dog
%	dat-petster/household.catdog
%
% OUTPUT 
%	plot-petster/pph.a.eps
%

font_size = 18; 

colors = petster_colors(); 

household_hamster = load('dat-petster/household.hamster');
household_cat     = load('dat-petster/household.cat');
household_dog     = load('dat-petster/household.dog');
household_catdog  = load('dat-petster/household.catdog');

d_hamster = sparse(household_hamster, 1, 1);
d_cat     = sparse(household_cat,     1, 1);
d_dog     = sparse(household_dog,     1, 1);
d_catdog  = sparse(household_catdog,  1, 1);

hold on; 

ax = [ 1 1250 0.000001 1 ];

axis(ax);

konect_plot_power_law(d_cat,     [], 0, colors.cat,      0, 0);
konect_plot_power_law(d_dog,     [], 0, colors.dog,      0, 0);
konect_plot_power_law(d_catdog,  [], 0, colors.catdog,   0, 0);
konect_plot_power_law(d_hamster, [], 0, colors.hamster,  0, 0);

set(gca, 'XTick', [1 10 100 1000 10000 100000]); 
set(gca, 'XMinorTick', 'on'); 

xlabel('Pets per household (p)', 'FontSize', font_size);
ylabel('P(x > p)', 'FontSize', font_size);

legend('Catster', 'Dogster', 'Catster + Dogster', 'Hamsterster', ...
       'Location', 'NorthEast', 'FontSize', font_size);

set(gca, 'FontSize', font_size); 

% Exponent line
alpha = 3.5;
p_min = 10;
p_max = 100
y_min = 0.1;
y_max = y_min / ((p_max / p_min)^(alpha-1));
color = 0.2 * [1 1 1];
line_width = 4.3;
line([p_min p_max], [y_min y_max], 'LineStyle', '--', 'LineWidth', line_width, 'Color', color);
text(p_max / 1.4, y_max * 5, sprintf('P(x = p) \\sim p^{-%.1f}', alpha), ...
     'Color', color, ...
     'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'FontSize', 22);

konect_print('plot-petster/pph.a.eps');
