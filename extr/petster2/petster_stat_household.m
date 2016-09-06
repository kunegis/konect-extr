%
% Statistics about households.
%
% PARAMETERS 
%	$SPECIES
%
% INPUT 
%	dat-petster/n.$SPECIES
%	dat-petster/h.$SPECIES
% 
% OUTPUT 
% 	dat-petster/stat_household.$SPECIES
%		[1] Pets per household
%

species = getenv('SPECIES');

n = load(sprintf('dat-petster/n.%s', species))
h = load(sprintf('dat-petster/h.%s', species))

pph = n / h

values = [ pph ]

save(sprintf('dat-petster/stat_household.%s', species), 'values', '-ascii');

