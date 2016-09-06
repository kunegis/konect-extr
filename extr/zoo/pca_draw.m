% -*-octave-*-
%
% Draw PCA plots. 
%
% INPUT
%	dat/decomp.mat
%	out.trolls
%
% OUTPUT
%	plot/pca.a.[uv].eps
%	plot/pca.l.eps
%	plot/pca.m.eps
%

file = fopen(strcat(getenv('TMP_BASE'), '.tmp'), 'w');

decomp = load('dat/decomp.mat'); 

trolls = load('out.trolls'); 

pca_draw_one('a.u', decomp.u_a, trolls);
pca_draw_one('a.v', decomp.v_a, trolls);

pca_draw_one('l', decomp.u_l, trolls);  

pca_draw_one('m', decomp.u_m(:, 2:end), trolls);  



fclose(file); 
