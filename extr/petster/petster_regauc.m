%
% Compute AUC of regression.
%
% PARAMETERS 
%	$SPECIES
%
% INPUT 
%	dat-petster/regfeature.$SPECIES.mat
%
% OUTPUT 
%	dat-petster/regauc.$SPECIES.mat
%		.auc	The AUC value 
%

species = getenv('SPECIES');

regfeature = load(sprintf('dat-petster/regfeature.%s.mat', species));

e2 = regfeature.e2;
F = regfeature.F;

assert(size(F,1) == 2 * e2);

auc = konect_auc( F, [ ones(e2, 1) ; zeros(e2, 1) ] )

save(sprintf('dat-petster/regauc.%s.mat', species), 'auc', '-v7.3');


