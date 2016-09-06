%
% Compute the features for household prediction.  The feature matrix
% contains the features for both the training and test set, and has
% the same row semantics as the matrix E in testset. 
%
% PARAMETERS 
%	$SPECIES
% 
% INPUT 
%	dat-petster/testset.[SPECIES].mat
%	dat-petster/out.petster-[SPECIES]-friend
%	dat-petster/n.[SPECIES]
%	dat-petster/ent.petster-[SPECIES].race 
%	dat-petster/ent.petster-[SPECIES].sex
%	dat-petster/ent.petster-[SPECIES].joined
%	dat-petster/ent.petster-[SPECIES].latlong
%	dat-petster/ent.petster-[SPECIES].birthday
%	dat-petster/ent.petster-[SPECIES].coloring  (not for dogs) 
%	dat-petster/ent.petster-[SPECIES].joinage   
%	dat-petster/ent.petster-[SPECIES].weight (only cats) 
%	dat-petster/ent.petster-[SPECIES].weightrange (only dogs) 
%	
% OUTPUT 
%	dat-petster/feature.[SPECIES].mat
%		.F ( [feature name] : (2*e) * 1)
%			Struct with feature vectors by feature name 
%		.e1, .e2
%		Lines correspond to those in testset.E;
%		Columns are features:
%		[1:degsum] Sum of degrees, log(1+x)
%

species = getenv('SPECIES');

consts = konect_consts(); 

n = load(sprintf('dat-petster/n.%s', species))

T = load(sprintf('dat-petster/out.petster-%s-friend', species));

testset = load(sprintf('dat-petster/testset.%s.mat', species));
E1 = testset.E(:,1);
E2 = testset.E(:,2);

ent_race = readent(sprintf('dat-petster/ent.petster-%s.race', species)); 
ent_sex = load(sprintf('dat-petster/ent.petster-%s.sex', species)); 
ent_joined = load(sprintf('dat-petster/ent.petster-%s.joined', species)); 
ent_latlong = load(sprintf('dat-petster/ent.petster-%s.latlong', species)); 
ent_birthday = load(sprintf('dat-petster/ent.petster-%s.birthday', species)); 
ent_joinage = load(sprintf('dat-petster/ent.petster-%s.joinage', species)); 

if ~strcmp(species, 'dog')
    ent_coloring = readent(sprintf('dat-petster/ent.petster-%s.coloring', species)); 
end
if strcmp(species, 'cat')
    ent_weight = load(sprintf('dat-petster/ent.petster-%s.weight', species)); 
end
if strcmp(species, 'dog')
    ent_weightrange = readent(sprintf('dat-petster/ent.petster-%s.weightrange', species)); 
end

assert(length(ent_race)      == n);  
assert(length(ent_sex)       == n);  
assert(length(ent_joined)    == n);  
assert(size  (ent_latlong,1) == n);  
assert(length(ent_birthday)  == n);  
assert(length(ent_joinage)   == n);  

if ~strcmp(species, 'dog')
    assert(length(ent_coloring)  == n);  
end
if strcmp(species, 'cat')
    assert(length(ent_weight)  == n);  
end
if strcmp(species, 'dog')
    assert(length(ent_weightrange)  == n);  
end

%
% Preparations
%

d = sparse([T(:,1) ; T(:,2)], 1, 1, n, 1);
A = sparse(T(:,1), T(:,2), 1, n, n);

%
% Compute features
%

F = struct();

F.degdiff = - abs(log((1 + d(E1)) ./ (1 + d(E2))));
F.jaccard = konect_predict_neib('jaccard', A, testset.E, consts.SYM);
F.cn = log(1 + konect_predict_neib('common', A, testset.E, consts.SYM));
F.raceeq = strcmp(ent_race(E1), ent_race(E2));
F.sexeq = (ent_sex(E1) == ent_sex(E2)) & (ent_sex(E1) ~= 0);
F.joinedeq = (ent_joined(E1) == ent_joined(E2)) & (ent_joined(E1) ~= 0) & (ent_joined(E2) ~= 0); 
F.joineddiff = - abs(ent_joined(E1) - ent_joined(E2)) .* ((ent_joined(E1) ~= 0) & (ent_joined(E2) ~= 0)); 
F.latlongeq = sum(ent_latlong(E1,:) == ent_latlong(E2,:), 2) == 2;
F.birthdaydiff = - abs(ent_birthday(E1) - ent_birthday(E2)) .* ((ent_birthday(E1) ~= 0) & (ent_birthday(E2) ~= 0));   
F.joinagediff = - abs(ent_joinage(E1) - ent_joinage(E2));  F.joinagediff(find(~isfinite(F.joinagediff))) = 0;

% Hamsterster does not allow friendships within a family 
if ~strcmp(species, 'hamster')
    F.friend =  full(A(E1 + n * (E2 - 1)) +  A(E2 + n * (E1 - 1)));
end

% Dogster has no coloration 
if ~strcmp(species, 'dog')
    F.coloringeq = strcmp(ent_coloring(E1), ent_coloring(E2)); 
end

% Only Catster has continuous weights 
if strcmp(species, 'cat')
    F.weightdiff = - abs(ent_weight(E1) - ent_weight(E2));  F.weightdiff(find(~isfinite(F.weightdiff))) = 0;
end

% Only Dogster has weight ranges
if strcmp(species, 'dog')
    F.weighteq = strcmp(ent_weightrange(E1), ent_weightrange(E2));
end

%
% Check that no feature equals NaN
%

names = fields(F)

for i = 1 : length(names)
    name = names{i}
    nn = sum(~isfinite(F.(name))) % Number of non-finite feature values 
    assert(nn == 0); 
end

%
% Save
%

e1 = testset.e1;
e2 = testset.e2; 

save(sprintf('dat-petster/feature.%s.mat', species), ...
     'F', 'e1', 'e2', ...
     '-v7.3');
