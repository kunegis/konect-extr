%
% Draw assortativity plot.
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
% OUTPUT 
%	plot-petster/assortativity.a.eps
%

font_size = 22; 

color_f = [ 1 0 0 ];
color_h = [ 0 1 0 ]; 

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

dhf = sum(Ahf,2);
dhh = sum(Ahh,2);
dcf = sum(Acf,2);
dch = sum(Ach,2);
ddf = sum(Adf,2);
ddh = sum(Adh,2);

ehf = (Ahf * dhf) ./ dhf;
ehh = (Ahh * dhh) ./ dhh;
ecf = (Acf * dcf) ./ dcf;
ech = (Ach * dch) ./ dch;
edf = (Adf * ddf) ./ ddf;
edh = (Adh * ddh) ./ ddh;

hold on;

subplot(1,3,1); 
hold on;
petster_assortativity_one(dcf, ecf, color_f);
petster_assortativity_one(dch, ech, color_h);
set(gca, 'XScale', 'log', 'YScale', 'log'); 
set(gca, 'XTick', [1e0, 1e2, 1e4]);
set(gca, 'YTick', [1e0, 1e2, 1e4]);
set(gca, 'TickLength', [0.05 0.05]); 
set(gca, 'FontSize', font_size); 
xlabel('Catster');
axis square tight;
axis([0.5 1e4 0.5 2e5]);
ax = axis(); 
set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on'); 
line([max(ax(1), ax(3)), max(ax(2), ax(4))], [max(ax(1), ax(3)), max(ax(2), ax(4))], 'LineStyle', '--', 'Color', [0 0 0]);

subplot(1,3,2); 
hold on;
petster_assortativity_one(ddf, edf, color_f);
petster_assortativity_one(ddh, edh, color_h);
set(gca, 'XScale', 'log', 'YScale', 'log'); 
set(gca, 'XTick', [1e0, 1e2, 1e4]);
set(gca, 'YTick', [1e0, 1e2, 1e4]);
set(gca, 'TickLength', [0.05 0.05]); 
set(gca, 'FontSize', font_size); 
xlabel('Dogster');
axis square tight;
axis([0.5 3e4 0.5 1e5]);
ax = axis(); 
set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on'); 
line([max(ax(1), ax(3)), max(ax(2), ax(4))], [max(ax(1), ax(3)), max(ax(2), ax(4))], 'LineStyle', '--', 'Color', [0 0 0]);

subplot(1,3,3); 
hold on;
petster_assortativity_one(dhf, ehf, color_f);
petster_assortativity_one(dhh, ehh, color_h);
set(gca, 'XScale', 'log', 'YScale', 'log'); 
set(gca, 'XTick', [1e0, 1e2]);
set(gca, 'YTick', [1e0, 1e1, 1e2]);
set(gca, 'TickLength', [0.05 0.05]); 
set(gca, 'FontSize', font_size); 
xlabel('Hamsterster');
axis square tight;
axis([0.5 8e2 0.5 5e2]);
ax = axis(); 
set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on'); 
line([max(ax(1), ax(3)), max(ax(2), ax(4))], [max(ax(1), ax(3)), max(ax(2), ax(4))], 'LineStyle', '--', 'Color', [0 0 0]);

konect_print('plot-petster/assortativity.a.eps');
