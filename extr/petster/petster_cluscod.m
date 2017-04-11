%
% Plot the clustering coefficient distribution for all networks.
%
% INPUT 
%	dat-petster/out.petster-hamster-friend
%	dat-petster/out.petster-hamster-household
%	dat-petster/out.petster-cat-friend
%	dat-petster/out.petster-cat-household
%	dat-petster/out.petster-dog-friend
%	dat-petster/out.petster-dog-household
%	dat-petster/n.hamster
%	dat-petster/n.cat
%	dat-petster/n.dog
%	dat-petster/h.hamster
%	dat-petster/h.cat
%	dat-petster/h.dog
%
% OUTPUT 
%	plot-petster/cluscod.a.eps
%

font_size = 20; 
line_width = 3;

colors = petster_colors(); 

Thf = load('dat-petster/out.petster-hamster-friend');
Thh = load('dat-petster/out.petster-hamster-household');
Tcf = load('dat-petster/out.petster-cat-friend');
Tch = load('dat-petster/out.petster-cat-household');
Tdf = load('dat-petster/out.petster-dog-friend');
Tdh = load('dat-petster/out.petster-dog-household');

nhf = load('dat-petster/n.hamster')
nhh = load('dat-petster/h.hamster')
ncf = load('dat-petster/n.cat')
nch = load('dat-petster/h.cat')
ndf = load('dat-petster/n.dog')
ndh = load('dat-petster/h.dog')

hold on;

Ahf = sparse(Thf(:,1), Thf(:,2), 1, nhf, nhf);
Ahh = sparse(Thh(:,1), Thh(:,2), 1, nhh, nhh);
Acf = sparse(Tcf(:,1), Tcf(:,2), 1, ncf, ncf);
Ach = sparse(Tch(:,1), Tch(:,2), 1, nch, nch);
Adf = sparse(Tdf(:,1), Tdf(:,2), 1, ndf, ndf);
Adh = sparse(Tdh(:,1), Tdh(:,2), 1, ndh, ndh);

Ahf = Ahf | Ahf';
Ahh = Ahh | Ahh';
Acf = Acf | Acf';
Ach = Ach | Ach';
Adf = Adf | Adf';
Adh = Adh | Adh';

% Do households first as they are faster 
'hh'
[dhh chh] = konect_clusco_simple(Ahh);
'hf'
[dhf chf] = konect_clusco_simple(Ahf);
'ch'
[dch cch] = konect_clusco_simple(Ach);
'cf'
[dcf ccf] = konect_clusco_simple(Acf);
'dh'
[ddh cdh] = konect_clusco_simple(Adh);
'df'
[ddf cdf] = konect_clusco_simple(Adf);

Fcf = cdfplot(dcf);
Fch = cdfplot(dch);
Fdf = cdfplot(ddf);
Fdh = cdfplot(ddh);
% Plot hamsters at the end
Fhf = cdfplot(dhf);
Fhh = cdfplot(dhh);

set(Fhf, 'LineWidth', line_width, 'Color', colors.hamster, 'LineStyle', '-');
set(Fhh, 'LineWidth', line_width, 'Color', colors.hamster, 'LineStyle', '--');
set(Fcf, 'LineWidth', line_width, 'Color', colors.cat, 'LineStyle', '-');
set(Fch, 'LineWidth', line_width, 'Color', colors.cat, 'LineStyle', '--');
set(Fdf, 'LineWidth', line_width, 'Color', colors.dog, 'LineStyle', '-');
set(Fdh, 'LineWidth', line_width, 'Color', colors.dog, 'LineStyle', '--');

axis([0 1 0 1]); 

title(''); 
xlabel('Local clustering coefficient (c)', 'FontSize', font_size); 
ylabel('P(x \leq c)', 'FontSize', font_size); 

set(gca, 'FontSize', font_size); 


legend(...
    { ...
        'Catster profiles', 'Catster accounts', ...
        'Dogster profiles', 'Dogster accounts', ...
        'Hamsterster profiles', 'Hamsterster accounts', ...
    }, ...
    'Location', 'SouthEast', 'FontSize', font_size);

konect_print('plot-petster/cluscod.a.eps'); 
