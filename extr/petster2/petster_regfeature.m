%
% Compute the regression scores.
%
% PARAMETERS 
%	$SPECIES 
%
% INPUT 
%	dat-petster/reg.$SPECIES.mat
%	dat-petster/feature.$SPECIES.mat
%
% OUTPUT 
%	dat-petster/regfeature.$SPECIES.mat
%		.e2	Size of test set
%		.F ((e2+e2) * 1)
%			Feature vector 
%

species = getenv('SPECIES');

reg = load(sprintf('dat-petster/reg.%s.mat', species));
feature = load(sprintf('dat-petster/feature.%s.mat', species));

names = fields(feature.F)

e1 = feature.e1
e2 = feature.e2

F =  reg.one * ones(e2 + e2, 1);

for i = 1 : length(names)

    name = names{i}
    Fi = feature.F.(name);

    F = F + reg.w.(name) * [ Fi(e1+1:e1+e2); Fi(e1+e2+e1+1:e1+e2+e1+e2) ];
end

F = (exp(-F) + 1) .^ -1;

assert(sum(~isfinite(F)) == 0); 

save(sprintf('dat-petster/regfeature.%s.mat', species), ...
     'F', 'e2', ...
     '-v7.3');
