%
% Plot histogram of join dates for all three datasets together  
%
% INPUT 
%	dat-petster/ent.petster-cat.joined
%	dat-petster/ent.petster-dog.joined
%	dat-petster/ent.petster-hamster.joined
%
% OUTPUT 
%	plot-petster/joined.a.eps
%

font_size = 17; 
factor = 0.05; % space at top of each plot 

colors = petster_colors(); 

species = getenv('SPECIES'); 

data_h = load('dat-petster/ent.petster-hamster.joined');
data_c = load('dat-petster/ent.petster-cat.joined');
data_d = load('dat-petster/ent.petster-dog.joined');

% Remove zero dates (they mean date is unknown)
data_h = data_h(find(data_h ~= 0)); 
data_c = data_c(find(data_c ~= 0)); 
data_d = data_d(find(data_d ~= 0)); 

% Year numbers
data_h = floor(data_h); 
data_c = floor(data_c); 
data_d = floor(data_d); 

year_min = min([min(data_h), min(data_c), min(data_d)]) 
year_max = max([max(data_h), max(data_c), max(data_d)]) 

d_h = sparse(data_h, 1, 1);
d_c = sparse(data_c, 1, 1);
d_d = sparse(data_d, 1, 1);

[x_h y_h z_h] = find(d_h)
[x_c y_c z_c] = find(d_c)
[x_d y_d z_d] = find(d_d)

subplot(3, 1, 1);   
bar(x_c, z_c, 'FaceColor', colors.cat); 
ax(1) = year_min - 0.5;
ax(2) = year_max + 0.5;
ax(3) = 0;
ax(4) = 50000; 
%ax(4) = max(z_c) * (1 + factor); 
axis(ax); 
ylabel('New cats', 'FontSize', font_size); 
set(gca, 'FontSize', font_size); 
tl = get(gca, 'TickLength')
set(gca, 'TickLength', [0 tl(2)]); 
set(gca, 'YGrid', 'on');
set(gca, 'XTick', []); 
set(gca, 'YTick', [0 20000 40000]);

subplot(3, 1, 2);   
bar(x_d, z_d, 'FaceColor', colors.dog); 
ax = axis();
ax(1) = year_min - 0.5;
ax(2) = year_max + 0.5;
ax(3) = 0;
ax(4) = 120000
%ax(4) = max(z_d) * (1 + factor); 
axis(ax); 
ylabel('New dogs', 'FontSize', font_size); 
set(gca, 'FontSize', font_size); 
tl = get(gca, 'TickLength')
set(gca, 'TickLength', [0 tl(2)]); 
set(gca, 'YGrid', 'on');
set(gca, 'XTick', []); 

subplot(3, 1, 3);   
bar(x_h, z_h, 'FaceColor', colors.hamster); 
ax = axis();
ax(1) = year_min - 0.5;
ax(2) = year_max + 0.5;
ax(3) = 0;
ax(4) = 1000;
%ax(4) = max(z_h) * (1 + factor); 
axis(ax); 
xlabel('Join date', 'FontSize', font_size); 
ylabel('New hamsters', 'FontSize', font_size); 
set(gca, 'FontSize', font_size); 
tl = get(gca, 'TickLength')
set(gca, 'TickLength', [0 tl(2)]); 
set(gca, 'YGrid', 'on');
set(gca, 'XTick', year_min:year_max); 

konect_print('plot-petster/joined.a.eps');

