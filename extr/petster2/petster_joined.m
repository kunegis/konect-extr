%
% Plot histogram of join dates. 
%
% PARAMETERS 
%	$SPECIES	"hamster"
%
% INPUT 
%	dat-petster/ent.petster-$SPECIES.joined
%
% OUTPUT 
%	plot-petster/joined.$SPECIES.a.eps
%

font_size = 18; 

species = getenv('SPECIES'); 

data = load(sprintf('dat-petster/ent.petster-%s.joined', species));

% Remove zero dates (they mean date is unknown)
data = data(find(data ~= 0)); 

size_data = size(data)
data_begin = data(1:40)' 

% Year numbers
data = floor(data); 

data_begin = data(1:40)'

d = sparse(data, 1, 1);

size_d = size(d) 

[x y z] = find(d)

bar(x, z); 

xlabel(sprintf('Join date (%s)', species), 'FontSize', font_size); 
ylabel('Frequency', 'FontSize', font_size); 

set(gca, 'FontSize', font_size); 

ax = axis();
ax(1) = min(x) - 0.5;
ax(2) = max(x) + 0.5;
axis(ax); 

tl = get(gca, 'TickLength')
set(gca, 'TickLength', [0 tl(2)]); 
set(gca, 'YGrid', 'on');

konect_print(sprintf('plot-petster/joined.%s.a.eps', species));

