% -*-octave-*-
%
% Plot an embedding.
%
% PARAMETERS
% 	pos,neg		n×n adjacency matrix for positive and negative edges
%	u		(n×2) coordinates

function pca_one(pos, neg, u)

hold on; 
gplot2(neg, u(:,1:2), '-or');
gplot2(pos, u(:,1:2), '-og', 'LineWidth',2);
axis square; 

