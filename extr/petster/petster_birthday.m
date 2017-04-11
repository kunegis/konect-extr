%
% Plot histogram of birthdays. 
%
% PARAMETERS 
%	$SPECIES	
%
% INPUT 
%	dat-petster/ent.petster-$SPECIES.birthday
%
% OUTPUT 
%	plot-petster/birthday.$SPECIES.a.eps
%

font_size = 18; 

species = getenv('SPECIES'); 

data = load(sprintf('dat-petster/ent.petster-%s.birthday', species));

size_data = size(data)
data_begin = data(1:40)' 

% Remove years of zero, which stand for unknown birthdates
data = data(find(data)); 

%
% Plot birth year
%

% Year numbers
data_year = floor(data); 

d = sparse(data_year, 1, 1);

size_d = size(d) 

[x y z] = find(d)

bar(x, z); 

xlabel(sprintf('Birthdate (%s)', species), 'FontSize', font_size); 
ylabel('Frequency', 'FontSize', font_size); 

set(gca, 'FontSize', font_size); 

ax = axis();
ax(1) = min(x) - 0.5;
ax(2) = max(x) + 0.5;
axis(ax); 

tl = get(gca, 'TickLength')
set(gca, 'TickLength', [0 tl(2)]); 
set(gca, 'YGrid', 'on');

pbaspect([3 1 1]); 

konect_print(sprintf('plot-petster/birthday.%s.a.eps', species));

