%
% Plot weight distribution of dogs. 
%
% INPUT 
%	dat-petster/weight.dog
%
% OUTPUT 
%	plot-petster/weight.a.dog.eps
%

font_size = 22;

colors = petster_colors(); 

data = load('dat-petster/weight.dog');

% Limits of groups, in avoirdupois-pounds, as used on Dogster
limits_lb = [ 0, 10 ; 10, 25; 25, 50; 50, 100; 100 150 ];

% Limits, in kilogram
limits_kg = limits_lb * 0.45359237;

assert(length(data) == size(limits_kg, 1)); 

hold on;

for i = 1 : length(data) 
    
    bar(mean(limits_kg(i,:)), ...
        data(i) / (limits_kg(i,2) - limits_kg(i,1)), ...
        limits_kg(i,2) - limits_kg(i,1), ...
        'FaceColor', colors.dog);

end

xlabel('Dog weight [kg]', 'FontSize', font_size); 
ylabel('Density [dogs / kg]', 'FontSize', font_size); 

set(gca, 'FontSize', font_size); 

%axis tight;

axis([0 70 0 16000]);

pbaspect([3 1 1]);

konect_print('plot-petster/weight.a.dog.eps');
