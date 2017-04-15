%
% Draw the age pyramid.
%
% PARAMETERS 
%	$SPECIES
%
% INPUT 
%	dat-petster/ent.petster-$SPECIES.sex
%	dat-petster/ent.petster-$SPECIES.birthday
%
% OUTPUT 
%	plot-petster/pyramid.a.$SPECIES.eps
%

age_highest = 20;
age_int = 1;
date_current = 2012; 
font_size_axis = 22;
font_size_bar  = 15; 
font_size_caption = 28; 
color_sex = 0.5 * [ 1 1 1 ]; 

species = getenv('SPECIES');

colors = petster_colors(); 

sex = load(sprintf('dat-petster/ent.petster-%s.sex', species));
birthdate = load(sprintf('dat-petster/ent.petster-%s.birthday', species));

hold on;

count_max = 0; 

% Determine count_max
for age = 0 : age_int : (age_highest - 1) 

    age_min = age;
    age_max = age + age_int;

    date_min = date_current - age_max;
    date_max = date_current - age_min;

    if age < age_highest - 1
        count_1 = sum((sex == 1) & (birthdate ~= 0) & (birthdate > date_min) & (birthdate <= date_max));
        count_2 = sum((sex == 1) & (birthdate ~= 0) & (birthdate > date_min) & (birthdate <= date_max));
    else
        count_1 = sum((sex == 2) & (birthdate ~= 0) & (birthdate <= date_max));
        count_2 = sum((sex == 2) & (birthdate ~= 0) & (birthdate <= date_max));
    end

    count_max = max(count_max, max(count_1, count_2)); 
end

for age = 0 : age_int : (age_highest - 1) 

    age_min = age;
    age_max = age + age_int;

    date_min = date_current - age_max;
    date_max = date_current - age_min;

    if age < age_highest - 1
        count_1 = sum((sex == 1) & (birthdate ~= 0) & (birthdate > date_min) & (birthdate <= date_max));
        count_2 = sum((sex == 2) & (birthdate ~= 0) & (birthdate > date_min) & (birthdate <= date_max));
    else
        count_1 = sum((sex == 1) & (birthdate ~= 0) & (birthdate <= date_max));
        count_2 = sum((sex == 2) & (birthdate ~= 0) & (birthdate <= date_max));
    end

    fill([0, -count_1, -count_1, 0], ...
         [age_max, age_max, age_min, age_min], ...
         colors.(species));
    fill([0, count_2, count_2, 0], ...
         [age_max, age_max, age_min, age_min], ...
         colors.(species));

    if age < age_highest - 1
        text_age = sprintf('%u', age);
    else
        text_age = sprintf('%u+', age); 
    end

    text(-count_1 - 0.03 * count_max, 0.5 * (age_max + age_min), text_age, ...
         'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
         'FontSize', font_size_bar); 
    text(+count_2 + 0.03 * count_max, 0.5 * (age_max + age_min), text_age, ...
         'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
         'FontSize', font_size_bar); 
end

axis([(-count_max * 1.1), (+count_max * 1.1), 0, (age_highest * 1.03)]); 

set(gca, 'FontSize', font_size_axis); 

if strcmp(species, 'dog')
    set(gca, 'XTick', [-20000, -10000, 0, 10000, 20000]);
    set(gca, 'XTickLabel', { '20000'; '10000'; '0'; '10000'; '20000' });
elseif strcmp(species, 'cat')
    set(gca, 'XTick', [-8000, -4000, 0, 4000, 8000]);
    set(gca, 'XTickLabel', { '8000'; '4000'; '0'; '4000'; '8000'; });
elseif strcmp(species, 'hamster')
    set(gca, 'XTick', [-250, -200, -150, -100, -50, 0, 50, 100, 150, 200, 250]);
    set(gca, 'XTickLabel', { '250'; '200'; '150'; '100'; '50'; '0'; '50'; '100'; '150'; '200'; '250'; });
else
    error();
end

set(gca, 'YTickLabelMode', 'Manual')
set(gca, 'YTick', []);
set(gca, 'YTickLabel', {}); 

text(-0.7 * count_max, 0.8 * age_highest, 'MALE', ...
     'HorizontalAlignment', 'center', 'VerticalAlign', 'middle', ...
     'FontSize', font_size_caption, 'Color', color_sex); 
text(+0.7 * count_max, 0.8 * age_highest, 'FEMALE', ...
     'HorizontalAlignment', 'center', 'VerticalAlign', 'middle', ...
     'FontSize', font_size_caption, 'Color', color_sex); 

konect_print(sprintf('plot-petster/pyramid.a.%s.eps', species));
