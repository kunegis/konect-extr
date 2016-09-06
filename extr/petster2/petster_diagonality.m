%
% Compute diagonality factor. 
%
% PARAMETERS 
%	$SPECIES
%
% INPUT 
%	dat-petster/delta.$SPECIES.mat
%
% OUTPUT 
%	dat-petster/diagonality.$SPECIES
%

species = getenv('SPECIES');

delta = load(sprintf('dat-petster/delta.%s.mat', species));

Lambda = delta.Lambda; 
Delta = delta.Delta;

assert(isreal(Delta)); 

diagonality = sum(diag(Delta) .^ 2) / sum(sum(Delta .^ 2))

save(sprintf('dat-petster/diagonality.%s', species), ...
     'diagonality', ...
     '-ascii'); 
