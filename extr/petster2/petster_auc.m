%
% Compute the AUC of each individual feature.
%
% PARAMETERS 
%	$SPECIES 
%
% INPUT 
%	dat-petster/feature.$SPECIES.mat
%
% OUTPUT 
%	dat-petster/auc.$SPECIES.mat
%		.auc ([feature name] : 1*1)  
%			Struct with AUC values by feature name
%

species = getenv('SPECIES');

feature = load(sprintf('dat-petster/feature.%s.mat', species));

F = feature.F;
names = fields(F)

f = length(names) 

e1 = feature.e1
e2 = feature.e2

auc = struct(); 

for i = 1 : f
    i
    name = names{i}
    Fi = F.(name)
    size_Fi = size(Fi)
    assert(size(Fi,1) == 2 * (e1 + e2));
    assert(size(Fi,2) == 1); 
    auc.(name) = konect_auc( ...
        [Fi(e1+1:e1+e2); Fi(e1+e2+e1+1:e1+e2+e1+e2)], ...
        [ ones(e2, 1); zeros(e2, 1) ] );
end

auc

save(sprintf('dat-petster/auc.%s.mat', species), 'auc', '-v7.3');
