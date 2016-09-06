%
% Plot evolution graph
%
% PARAMETERS 
%	$STATISTIC
%	$YEARS
%	$GROUPS
%
% INPUT 
%	dat-lkml/statistic.$YEAR.$GROUP.$STATISTIC
%		for all $YEAR in $YEARS and all $GROUP in $GROUPS
%
% OUTPUT 
%	plot-lkml/evolution.a.$STATISTIC.eps
%

statistic = getenv('STATISTIC')

years_text = getenv('YEARS')
groups_text = getenv('GROUPS')

years_texts  = regexp(years_text,  '[0-9]+', 'match')
groups_texts = regexp(groups_text, '[0-9]+', 'match')

for i = 1 : length(years_texts)
    [v c] = sscanf(years_texts{i}, '%u');
    if c ~= 1,  error();  end
    years(i) = v;
end

for i = 1 : length(groups_texts)
    [v c] = sscanf(groups_texts{i}, '%u');
    if c ~= 1,  error();  end
    groups(i) = v;
end

years
groups

font_size = 22; 
line_width = 2.5;
marker_size = 7;

marker_styles = lkml_marker_styles(); 
colors = lkml_colors(); 
labels = lkml_labels(); 
labels_statistic = lkml_labels_statistic(); 

hold on; 

for i = 1 : length(groups)

    g = groups(i)

    for j = 1 : length(years)

        y = years(j)
        value = load(sprintf('dat-lkml/statistic.%u.%u.%s', y, g, statistic)) 
        values(j) = value;
    end

    marker_style = marker_styles{g};
    color = colors{g}; 

    plot(years, values, ['-' marker_style], 'Color', color, 'LineWidth', line_width, 'MarkerSize', marker_size, 'MarkerFaceColor', [1 1 1]);
end

%legend(labels, 'FontSize', font_size - 5, 'Location', 'NorthWest');

set(gca, 'FontSize', font_size);

xlabel('Year', 'FontSize', font_size);
ylabel(labels_statistic.(statistic), 'FontSize', font_size); 

ax = axis();
ax(1) = min(years) - 1/2;
ax(2) = max(years) + 1/2; 
axis(ax);

konect_print(sprintf('plot-lkml/evolution.a.%s.eps', statistic));

%
% Legend
%

hold on; 

for i = 1 : length(groups)

    g = groups(i)

    marker_style = marker_styles{g};
    color = colors{g}; 

    plot(-1, -1, ['-' marker_style], 'Color', color, 'LineWidth', line_width, 'MarkerSize', marker_size, 'MarkerFaceColor', [1 1 1]);
end

axis([0 1 0 1])
axis off

legend(labels, 'FontSize', font_size, 'Location', 'NorthWest');

konect_print(sprintf('plot-lkml/evolution.legend.%s.eps', statistic));
