%
% Perform a power law analysis of the pets per household
% distribution. 
%
% PARAMETERS 
%	$SPECIES 
%
% INPUT 
%	dat-petster/household.$SPECIES
%
% OUTPUT 
%	dat-petster/power_pph.$SPECIES
%		Contains values as returned by
%		konect_power_law_range() 
%

consts = konect_consts(); 

species = getenv('SPECIES');

household = load(sprintf('dat-petster/household.%s', species));

d = sparse(household, 1, 1); 

assert(size(d,2) == 1); % Make sure it's a column vector 

values = konect_power_law_range(d, consts.POSITIVE, 1)

save(sprintf('dat-petster/power_pph.%s', species), 'values', '-ascii');

