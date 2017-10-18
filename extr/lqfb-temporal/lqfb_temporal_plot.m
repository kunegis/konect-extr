%
% Plot the temporal statistics over time. 
%
% INPUT 
%	dat-lqfb/temporal.mat
%
% OUTPUT 
%	plot-lqfb/temporal.a.eps
%

line_width = 1.3; 
font_size = 9;
ratio = 6;

% Date of the convention 
convention = 2012 + 3/12 + 29/30/12;

content = load('dat-lqfb/temporal.mat');

data = content.data;
statistics = content.statistics
t_all = content.t_all; 

colors = struct(); 
colors.adds         = [ 0   1   0   ];
colors.removes      = [ 1   0   0   ]; 
colors.avgdegreeasym= [ 0.9 0.6 0   ];
colors.uniquevolume = [ 0   0   0   ];
colors.gini         = [ 1   0   0   ];
colors.reciprocity  = [ 0.2 0.2 1   ];
colors.clusco       = [ 0   0.8 0.8 ];
colors.coco         = [ 0   0.9 0   ];
colors.cocos        = [ 0.6 0.7 0   ];
colors.meandist     = [ 1   0   1   ];

labels = struct();
labels.uniquevolume = 'Dlg.';
labels.avgdegreeasym= 'Dlg. per user';
labels.gini         = 'Gini';
labels.reciprocity  = 'Recipr.';
labels.meandist     = 'Mean dist.';
labels.clusco       = 'Clustering';
labels.coco         = 'LCC';
labels.cocos        = 'LSCC';
labels.adds         = 'Activity';

x_left = 0.08; 
y_bottom = 0.08;
y_spaceratio = 0.2;

t_year = t_all / 60 / 60 / 24 / 365.24 + 1970;

range_step = (t_year(end) - t_year(1)) / (length(t_year) - 1); 

assert(strcmp(statistics{2}, 'removes'));
statistics(2) = []; 
assert(strcmp(statistics{7}, 'cocos'));
statistics(7) = []; 
assert(strcmp(statistics{7}, 'meandist'));
statistics(7) = []; 

statistics

k = length(statistics);

for j = 1 : k
    statistic = statistics{j}

    axes('Position', ...
         [x_left, ...
          (y_bottom + (1 - y_bottom) * (k - j) / (k + 1)), ...
          (1-x_left), ...
          ((1-y_bottom) * (1-y_spaceratio) / (k+1))]); 

    if strcmp(statistic, 'adds')

        nn_pos = data.adds;
        nn_neg = data.removes;

        hold on; 
        bar(t_year, nn_pos,   'FaceColor', colors.adds,    'EdgeColor', colors.adds); 
        bar(t_year, - nn_neg, 'FaceColor', colors.removes, 'EdgeColor', colors.removes); 

    elseif strcmp(statistic, 'removes')
        error(); 
    else
        plot(t_year, data.(statistic), '-', 'Color', colors.(statistic), ...
             'LineWidth', line_width);
    end

    ax(1) = t_year(1);
    ax(2) = t_year(end);
    
    if strcmp(statistic, 'uniquevolume')
        ax(3) = 0;  ax(4) = 7500; 
    elseif strcmp(statistic, 'avgdegreeasym')
        ax(3) = 4;  ax(4) = 8;
    elseif strcmp(statistic, 'gini')
        ax(3) = 0.63; ax(4) = 0.69;
    elseif strcmp(statistic, 'reciprocity')
        ax(3) = 0.09;  ax(4) = 0.18;
    elseif strcmp(statistic, 'clusco')
        ax(3) = 0.05;  ax(4) = 0.16;
    elseif strcmp(statistic, 'coco')
        ax(3) = 0;  ax(4) = 3000;
    elseif strcmp(statistic, 'cocos')
        ax(3) = 0;  ax(4) = 500;
    elseif strcmp(statistic, 'meandist')
        ax(3) = 2.6;  ax(4) = 2.800001;
    elseif strcmp(statistic, 'adds')
        ax(3) = -250;  ax(4) = +2200; 
    else
        error(); 
    end

    set(gca, 'FontSize', font_size); 

    axis(ax); 
    if j == length(statistics),  xlabel('Time', 'FontSize', font_size);  end;
    ylabel(labels.(statistic), 'FontSize', font_size);

    set(gca, 'XTick', [2011 2012 2013]);
    if j == length(statistics)
        set(gca, 'XTickLabels', { '2011'; '2012'; '2013' });
    else
        set(gca, 'XTickLabels', { ''; ''; '' }); 
    end

    set(gca, 'YTickMode','manual')
    set(gca, 'YTickLabel',num2str(get(gca,'YTick')', '%g'))

    pbaspect([ratio 1 1]);
    
    ax = axis(); 
    line([convention convention], ax(3:4), 'LineStyle', '--', ...
         'Color', [0 0 0]); 
end

konect_print('plot-lqfb/temporal.a.eps');
