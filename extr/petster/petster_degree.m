%
% Draw an overlay of all degree distributions of the friends and
% household networks. 
%
% INPUT 
%	dat-petster/out.petster-hamster-friend
%	dat-petster/out.petster-cat-friend
%	dat-petster/out.petster-dog-friend
%	dat-petster/out.petster-hamster-household
%	dat-petster/out.petster-cat-household
%	dat-petster/out.petster-dog-household
%
% OUTPUT 
%	plot-petster/degree.[a].eps
%

font_size = 18; 
font_size_legend = 15; 

colors = petster_colors(); 

T_hf = load('dat-petster/out.petster-hamster-friend');
T_cf = load('dat-petster/out.petster-cat-friend');
T_df = load('dat-petster/out.petster-dog-friend');
T_hh = load('dat-petster/out.petster-hamster-household');
T_ch = load('dat-petster/out.petster-cat-household');
T_dh = load('dat-petster/out.petster-dog-household');

d_hf = sparse([T_hf(:,1); T_hf(:,2)], 1, 1);
d_cf = sparse([T_cf(:,1); T_cf(:,2)], 1, 1);
d_df = sparse([T_df(:,1); T_df(:,2)], 1, 1);
d_hh = sparse([T_hh(:,1); T_hh(:,2)], 1, 1);
d_ch = sparse([T_ch(:,1); T_ch(:,2)], 1, 1);
d_dh = sparse([T_dh(:,1); T_dh(:,2)], 1, 1);

hold on; 

konect_plot_power_law(d_cf, [], 0, colors.cat,     0, 0, '-');
konect_plot_power_law(d_df, [], 0, colors.dog,     0, 0, '-');
konect_plot_power_law(d_hf, [], 0, colors.hamster, 0, 0, '-');
konect_plot_power_law(d_ch, [], 0, colors.cat,     0, 0, '--');
konect_plot_power_law(d_dh, [], 0, colors.dog,     0, 0, '--');
konect_plot_power_law(d_hh, [], 0, colors.hamster, 0, 0, '--');

set(gca, 'XMinorTick', 'on'); 

xlabel('Number of friends (d)', 'FontSize', font_size);
ylabel('P(x > d)', 'FontSize', font_size);

legend(...
    {'Catster [p]', 'Dogster [p]', 'Hamsterster [p]', ...
    'Catster [a]', 'Dogster [a]', 'Hamsterster [a]'}, ...
    'Location', 'NorthEast', 'FontSize', font_size_legend);

set(gca, 'FontSize', font_size); 

% Power-law line
x_min = 1e2;
x_max = 1e4;
y_max = 2e-1;
gamma = 2.2;
y_min = y_max / ((x_max / x_min) ^ (gamma - 1));
line([x_min x_max], [y_max y_min], 'LineStyle', '--', 'Color', [.2 .2 .2], ...
     'LineWidth', 4.3);
text(x_max / 1.4, y_min * 5, sprintf('P(x = d) \\sim d^{-%.1f}', gamma), ...
     'Color', [.2 .2 .2], ...
     'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'FontSize', 22);

konect_print('plot-petster/degree.a.eps');
