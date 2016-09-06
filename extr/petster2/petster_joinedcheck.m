%
% Check whether all pets in the same household have the same join
% date. 
%
% We know now that this is not true, so the code below will assert
% that this is not the case. 
%
% PARAMETERS 
%	$SPECIES
%
% INPUT 
%	dat-petster/ent.petster-$SPECIES.joined
%	dat-petster/household.$SPECIES
% 
% OUTPUT 
%	dat-petster/joinedcheck.$SPECIES
%

species = getenv('SPECIES');

j = load(sprintf('dat-petster/ent.petster-%s.joined', species));
h = load(sprintf('dat-petster/household.%s', species));

assert(length(j) == length(h));

n = length(j) 

% Number of pairs of pets in same household with different join date 
delta = 0; 

for i = 1 : n
    delta = delta + sum(j(find(h == h(i))) ~= j(i));
    if delta > 0,  break;  end;
end

assert(delta > 0); 

save(sprintf('dat-petster/joinedcheck.%s', species), 'delta', '-ascii'); 
