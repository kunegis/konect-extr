%
% Draw spectral plots.
%
% PARAMETERS 
%	$SPECIES
%
% INPUT 
%	dat-petster/delta.$SPECIES.mat
%
% OUTPUT 
%	plot-petster/spectral.a.$SPECIES.eps
%

species = getenv('SPECIES');

colors = petster_colors(); 

delta = load(sprintf('dat-petster/delta.%s.mat', species));

Lambda = delta.Lambda; 
Delta = delta.Delta;

%
% (a) - Delta
%

q = 50; % Size to show (250 is too big)

konect_imageubu(Delta(1:q, 1:q));

konect_print(sprintf('plot-petster/spectral.a.%s.eps', species));

%
% (b) - Spectral mapping
%

font_size = 30;

% Make darker so it's better visible
color_b = 0.5 * colors.(species); 

plot(diag(Lambda), diag(Delta), 'o', 'MarkerSize', 12, 'Color', color_b);

set(gca, 'FontSize', font_size);

xlabel('\Lambda_{ii}', 'FontSize', font_size);
ylabel('\Delta_{ii}', 'FontSize', font_size);

axis tight;
ax = axis();
ax(3) = 0;
axis(ax); 
line([0 0], ax(3:4), 'LineStyle', '--', 'Color', [.2 .2 .2], ...
     'LineWidth', 4);

konect_print(sprintf('plot-petster/spectral.b.%s.eps', species));
