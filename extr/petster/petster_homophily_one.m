%
% Compute homophily indicators for one species.
%
% We use two different methods, both from [1]:
%
% (a) For categorical variables:  Eq (2). 
%
% Formula:  r = (Tr(E) - ||E^2||) / (1 - ||E^2||)
% where E is the class*class edge count matrix, normalized in a way
% that the sum of all entries in E is one. 
% We need to transform the all these features into continuous IDs 
%
% (b) For numerical properties:  Eq (21).  This is the Pearson
% correlation between all pairs of connected nodes. 
%
% PARAMETERS 
%	$SPECIES 
%
% INPUT 
%	dat-petster/n.$SPECIES
%	dat-petster/h.$SPECIES
%	dat-petster/out.petster-$SPECIES-friend 
%	dat-petster/ent.petster-$SPECIES.birthday
%	dat-petster/ent.petster-$SPECIES.sex
%	dat-petster/ent.petster-$SPECIES.joined
%	dat-petster/ent.petster-$SPECIES.joinage
%	dat-petster/ent.petster-$SPECIES.weight (only cats) 
%	dat-petster/ent.petster-$SPECIES.race-id
%	dat-petster/ent.petster-$SPECIES.coloring-id (not for dogs) 
%	dat-petster/ent.petster-$SPECIES.weightrange-id (only dogs) 
%
% OUTPUT 
%	dat-petster/homophily.$SPECIES.mat
%	.h_f	Struct of homophily values for friendship links, by
%		feature name 
%	.h_h	Struct of homophily values for same households, by
%		feature name
%	.p_f	p-values/errors for friendships
%	.p_h	p-values/errors for households 
%	.t_f	Type for friendships ('category'/'number')
%	.t_h	Type for households ('category'/'number')
%
% REFERENCES 
%   [1] Mixing Patterns in Networks.  M.E.J. Newman.   Phys. Rev. E
%	67, 026126 (2003)  
%

species = getenv('SPECIES')

n = load(sprintf('dat-petster/n.%s', species)); 
h = load(sprintf('dat-petster/h.%s', species)); 

%
% Friendship edges
%

F = load(sprintf('dat-petster/out.petster-%s-friend', species));

F1 = F(:,1);
F2 = F(:,2); 

%
% Number of pets per household
%

household = load(sprintf('dat-petster/household.%s', species));
assert(size(household,1) == n);
assert(size(household,2) == 1); 

pph = sparse(household, 1, 1, h, 1); 
assert(size(pph,1) == h);
assert(size(pph,2) == 1); 
assert(sum(pph < 1) == 0); % Every household has at least one pet 

%
% Household edges
%

H1 = []; 
H2 = []; 

t = konect_timer(h);

for i = 1 : h

    t = konect_timer_tick(t, i); 
    
    k = pph(i);
    assert(k >= 1); 

    if k == 1
        continue
    end;
    
    us = find(household == i);
    assert(k == length(us)); 

    ii = randi(k);
    jj = randi(k);
    while jj == ii
        jj = randi(k);
    end

    H1 = [ H1 ; us(1) * ones(k-1,1) ];
    H2 = [ H2 ; us(2:end) ]; 
end

konect_timer_end(t); 

assert(size(H1,1) == n - h);
assert(size(H2,1) == n - h); 

%
% Features
%

ent_birthday = load(sprintf('dat-petster/ent.petster-%s.birthday', species));
ent_sex      = load(sprintf('dat-petster/ent.petster-%s.sex', species));
ent_joined   = load(sprintf('dat-petster/ent.petster-%s.joined', species));
ent_joinage  = load(sprintf('dat-petster/ent.petster-%s.joinage', species));
ent_latlong  = load(sprintf('dat-petster/ent.petster-%s.latlong', species));
ent_race     = load(sprintf('dat-petster/ent.petster-%s.race-id', species));

assert(length(ent_birthday) == n); 
assert(length(ent_sex) == n); 
assert(length(ent_joined) == n); 
assert(length(ent_joinage) == n); 
assert(length(ent_latlong) == n); 
assert(length(ent_race) == n); 

if strcmp(species, 'cat')
    ent_weight  = load(sprintf('dat-petster/ent.petster-%s.weight', species));
    assert(length(ent_weight) == n); 
end
if ~ strcmp(species, 'dog')
    ent_coloring= load(sprintf('dat-petster/ent.petster-%s.coloring-id', species));
    assert(length(ent_coloring) == n); 
end
if strcmp(species, 'dog')
    ent_weightrange= load(sprintf('dat-petster/ent.petster-%s.weightrange-id', species));
    assert(length(ent_weightrange) == n); 
end

d = sparse([F1; F2], 1, 1, n, n); 

%
% For friendship network 
%

h_f = struct(); 
p_f = struct(); 

ii_birthday = (ent_birthday(F1) ~= 0) & (ent_birthday(F2) ~= 0);
[h_f.birthday, p_f.birthday] = ...
    corr(ent_birthday(F1(ii_birthday)), ent_birthday(F2(ii_birthday)));
t_f.birthday = 'number';

ii_joined = (ent_joined(F1) ~= 0) & (ent_joined(F2) ~= 0);
[h_f.joined, p_f.joined] = ...
    corr(ent_joined(F1(ii_joined)), ent_joined(F2(ii_joined)));
t_f.joined = 'number';

ii_joinage = isfinite(ent_joinage(F1)) & isfinite(ent_joinage(F2));
[h_f.joinage, p_f.joinage] = ...
    corr(ent_joinage(F1(ii_joinage)), ent_joinage(F2(ii_joinage)));
t_f.joinage = 'number';

[h_f.degree, p_f.degree] = ...
    corr(log(1 + d(F1)), log(1 + d(F2))); 
t_f.degree = 'number';

[h_f.sex, p_f.sex] = homophily_category(ent_sex, F1, F2); 
t_f.sex = 'category';

[h_f.race, p_f.race] = homophily_category(ent_race, F1, F2); 
t_f.race = 'category'; 

ii_latlong = isfinite(ent_latlong(F1,1)) & isfinite(ent_latlong(F2,1));
[h_f.latlong, p_f.latlong] = distcorr_geo(ent_latlong(F1(ii_latlong),:), ent_latlong(F2(ii_latlong),:)); 
t_f.latlong = 'number';

if strcmp(species, 'cat')
    ii_weight = isfinite(ent_weight(F1)) & isfinite(ent_weight(F2));
    [h_f.weight, p_f.weight] = ...
        corr(ent_weight(F1(ii_weight)), ent_weight(F2(ii_weight)));
    t_f.weight = 'number';
end
if ~ strcmp(species, 'dog')
    [h_f.coloring, p_f.coloring] = homophily_category(ent_coloring, F1, F2); 
    t_f.coloring = 'category';
end
if strcmp(species, 'dog')
    [h_f.weightrange, p_f.weightrange] = homophily_category(ent_weightrange, F1, F2); 
    t_f.weightrange = 'category'; 
end

%
% For household network 
%

h_h = struct(); 
p_h = struct(); 
t_h = struct(); 

ii_birthday = (ent_birthday(H1) ~= 0) & (ent_birthday(H2) ~= 0);
[h_h.birthday, p_h.birthday] = ...
    corr(ent_birthday(H1(ii_birthday)), ent_birthday(H2(ii_birthday)));
t_h.birthday = 'number';

ii_joined = (ent_joined(H1) ~= 0) & (ent_joined(H2) ~= 0);
[h_h.joined, p_h.joined] = ...
    corr(ent_joined(H1(ii_joined)), ent_joined(H2(ii_joined)));
t_h.joined = 'number';

ii_joinage = isfinite(ent_joinage(H1)) & isfinite(ent_joinage(H2));
[h_h.joinage, p_h.joinage] = ...
    corr(ent_joinage(H1(ii_joinage)), ent_joinage(H2(ii_joinage)));
t_h.joinage = 'number';

%if ~strcmp(species, 'hamster')
    [h_h.degree, p_h.degree] = ...
        corr(log(1 + d(H1)), log(1 + d(H2))); 
    t_h.degree = 'number';
%end

[h_h.sex, p_h.sex] = homophily_category(ent_sex, H1, H2); 
t_h.sex = 'category';

[h_h.race, p_h.race] = homophily_category(ent_race, H1, H2); 
t_h.race = 'category'; 

% There is not latlong homophily because pets in the same household
% always have the same location.  

if strcmp(species, 'cat')
    ii_weight = isfinite(ent_weight(H1)) & isfinite(ent_weight(H2));
    [h_h.weight, p_h.weight] = ...
        corr(ent_weight(H1(ii_weight)), ent_weight(H2(ii_weight)));
    t_h.weight = 'number';
end
if ~ strcmp(species, 'dog')
    [h_h.coloring, p_h.coloring] = homophily_category(ent_coloring, H1, H2); 
    t_h.coloring = 'category';
end
if strcmp(species, 'dog')
    [h_h.weightrange, p_h.weightrange] = homophily_category(ent_weightrange, H1, H2); 
    t_h.weightrange = 'category'; 
end

%
% Output 
%

h_f
p_f
t_f
h_h
p_h
t_h

save(sprintf('dat-petster/homophily.%s.mat', species), ...
     'h_f', 'p_f', 't_f', 'h_h', 'p_h', 't_h', ...
     '-v7.3');
