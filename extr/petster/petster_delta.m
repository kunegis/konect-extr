%
% Compute the matrix Δ = U'RR'U. 
%
% PARAMETERS 
%	$SPECIES
%
% INPUT 
%	dat-petster/n.$SPECIES
%	dat-petster/h.$SPECIES
%	dat-petster/decomposition.$SPECIES.mat
%	dat-petster/household.$SPECIES
%
% OUTPUT 
%	dat-petster/delta.$SPECIES.mat
%	.Lambda
%	.Delta
%


species = getenv('SPECIES');

n = load(sprintf('dat-petster/n.%s', species));
h = load(sprintf('dat-petster/h.%s', species));
decomposition = load(sprintf('dat-petster/decomposition.%s.mat', species));
household = load(sprintf('dat-petster/household.%s', species)); 

U = decomposition.U; 
R = sparse(1:n, household, 1, n, h); 

UR = U' * R;
Delta = (UR * UR')

Lambda = decomposition.D;

save(sprintf('dat-petster/delta.%s.mat', species), ...
     'Lambda', 'Delta', ...
     '-v7.3'); 
