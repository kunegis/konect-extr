%
% Plot pie charts of sex distributions. 
%
% INPUT 
%	dat-petster/ent.petster_orig-hamster.sex
%	dat-petster/ent.petster_orig-cat.sex
%	dat-petster/ent.petster_orig-dog.sex
%
% OUTPUT 
%	plot-petster/sex.a.eps
%

font_size = 18; 
labels = {'F', 'M'}; 

sex_hamster = load('dat-petster/ent.petster_orig-hamster.sex');
sex_cat     = load('dat-petster/ent.petster_orig-cat.sex');
sex_dog     = load('dat-petster/ent.petster_orig-dog.sex');

sex_f_hamster = sum(sex_hamster == 2);
sex_m_hamster = sum(sex_hamster == 1);
sex_f_cat     = sum(sex_cat     == 2);
sex_m_cat     = sum(sex_cat     == 1);
sex_f_dog     = sum(sex_dog     == 2);
sex_m_dog     = sum(sex_dog     == 1);

subplot(1, 3, 1);
pie([sex_f_cat,     sex_m_cat    ], labels);
title('Catster', 'FontSize', font_size);
set(gca, 'FontSize', font_size); 

subplot(1, 3, 2);
pie([sex_f_dog,     sex_m_dog    ], labels);
title('Dogster', 'FontSize', font_size); 
set(gca, 'FontSize', font_size); 

subplot(1, 3, 3);
pie([sex_f_hamster, sex_m_hamster], labels);
title('Hamster', 'FontSize', font_size); 
set(gca, 'FontSize', font_size); 

konect_print('plot-petster/sex.a.eps');
