%
% Build a household-level friendship network. 
%
% PARAMETERS 
%	$SPECIES 
%
% INPUT 
%	dat-petster/household.$SPECIES
%	dat-petster/out.petster-$SPECIES-friend
%	dat-petster/h.$SPECIES
%
% OUTPUT 
%	dat-petster/out.petster-$SPECIES-household
%

species = getenv('SPECIES'); 

% Contains new pet IDs
T = load(sprintf('dat-petster/out.petster-%s-friend', species));

household = load(sprintf('dat-petster/household.%s', species)); 

h = load(sprintf('dat-petster/h.%s', species));

% Contains household IDs    
Th = [ household(T(:,1)), household(T(:,2)) ];
assert(size(Th,2) == 2);
assert(size(Th,1) == size(T,1));

% Check whether there are household-internal pet-pet friendship links

m_internal = sum(Th(:,1) == Th(:,2))

% Yes, there are intra-household links 

A = sparse(Th(:,1), Th(:,2), 1, h, h);

A = A + A';
A = double(A ~= 0);
A = triu(A, 1); % Note:  the "1" also removes the diagonal, removing
                % loops 

[x y] = find(A); 

OUT = fopen(sprintf('dat-petster/out.petster-%s-household', species), 'w');
if OUT < 0,  error();  end
fprintf(OUT, '%% sym unweighted\n'); 
fprintf(OUT, '%u\t%u\n', [x y]');
if fclose(OUT) < 0,  error();  end
