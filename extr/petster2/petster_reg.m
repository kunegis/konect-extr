%
% Perform logistic regression. 
%
% PARAMETERS 
%	$SPECIES 
%
% INPUT 
%	dat-petster/feature.$SPECIES.mat
%
% OUTPUT 
% 	dat-petster/reg.$SPECIES.mat
%	.names	(f, string) Names of the features
%	.one	weight of constant feature
%	.w	([feature]) weights of the features
%	,corr_F (f*f) Pearson correlations between features
%

species = getenv('SPECIES'); 

feature = load(sprintf('dat-petster/feature.%s.mat', species)); 

e1 = feature.e1;
e2 = feature.e2;

names = fields(feature.F) 

f = length(names); 

for i = 1 : f
    i
    name = names{i}
    Fi = feature.F.(name); 
    assert(size(Fi,1) == 2 * (e1 + e2));
    Fi_training = [ Fi(1:e1) ; Fi(e1+e2+1:e1+e2+e1) ];
    assert(size(Fi_training,1) == 2 * e1); 
    F(1:(2*e1), i) = Fi_training; 
end

size_F = size(F) 

corr_F = corr(F) 

% Labels in mnrfit() must begin at 1.  We use:
% positive test set:  label = 1
% negative test set:  label = 0 

target = [ ones(e1, 1) ; 2 * ones(e1, 1) ]; 

[B dev stats] = mnrfit(F, target)

stats.p

assert(length(B) == f + 1); 

one = B(1);
ww = B(2:end); 

w = struct();
for i = 1 : f
    i
    name = names{i}
    w.(name) = ww(i);
end

save(sprintf('dat-petster/reg.%s.mat', species), '-v7.3', ...
     'names', 'one', 'w', 'corr_F');
