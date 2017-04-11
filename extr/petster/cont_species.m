%
% Generate the continuous data for one species.
%
% PARAMETERS 
%	$SPECIES	hamster/cat/dog (but not catdog)
%
% INPUT 
%	dat-petster/out.petster_orig-$SPECIES-friend
%	dat-petster/out.petster_orig-$SPECIES-family
%	dat-petster/ent.petster_orig-$SPECIES.origid
%
% OUTPUT 
%	dat-petster/out.petster-$SPECIES-friend
%	dat-petster/out.petster-$SPECIES-family 
%	dat-petster/n.$SPECIES
%		Total number of pets (including those not in the ENT
%		files) 
%

species = getenv('SPECIES'); 

T1 = load(sprintf('dat-petster/out.petster_orig-%s-friend', species));
T2 = load(sprintf('dat-petster/out.petster_orig-%s-family', species)); 

origid = load(sprintf('dat-petster/ent.petster_orig-%s.origid', species));
n = length(origid)

% Contains nonzero value at index corresponding to pets for which
% there are links but no profile. 
newids = sparse([T1(:,1); T1(:,2); T2(:,1); T2(:,2)], 1, 1);
newids(origid) = 0;

% Remove edges between pets for which we don't have the profile 

e1 = ((newids(T1(:,1)) == 0) & (newids(T1(:,2)) == 0));
e2 = ((newids(T2(:,1)) == 0) & (newids(T2(:,2)) == 0));

T1 = T1(e1,:);
T2 = T2(e2,:);

% Mapping of old ID to new ID
id2(origid,1) = (1:n)'; 

% Version of T with new IDs
G1 = [ id2(T1(:,1)) , id2(T1(:,2)) ];
G2 = [ id2(T2(:,1)) , id2(T2(:,2)) ];

assert(size(G1,2) == 2);
assert(size(G2,2) == 2);

%
% Make simple network
%

A1 = sparse(G1(:,1), G1(:,2), 1, n, n);
A1 = A1 + A1';
A1 = triu(A1);
A1 = (A1 ~= 0);
A1 = A1 - spdiags(diag(A1), [0], n, n); 
[x y z] = find(A1);
G1 = [x y];

A2 = sparse(G2(:,1), G2(:,2), 1, n, n);
A2 = A2 + A2';
A2 = triu(A2);
A2 = (A2 ~= 0);
assert(sum(diag(A2)) == 0);
[x y z] = find(A2);
G2 = [x y];

%
% Save
%

OUT1 = fopen(sprintf('dat-petster/out.petster-%s-friend', species), 'w')
if OUT1 < 0,  error;  end
fprintf(OUT1, '%% sym unweighted\n'); 
fprintf(OUT1, '%u\t%u\n', G1');
if fclose(OUT1) < 0,  error,  end;

OUT2 = fopen(sprintf('dat-petster/out.petster-%s-family', species), 'w')
if OUT2 < 0,  error;  end
fprintf(OUT2, '%u\t%u\n', G2');
if fclose(OUT2) < 0,  error,  end;

OUT3 = fopen(sprintf('dat-petster/n.%s', species), 'w');
if OUT3 < 0,  error();  end;
fprintf(OUT3, '%u\n', n); 
if fclose(OUT3) < 0,  error();  end;
