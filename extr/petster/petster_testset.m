%
% Generate the test set.
%
% PARAMETERS 
%	$SPECIES
%
% INPUT 
%	dat-petster/household.$SPECIES
%	dat-petster/n.$SPECIES
%	dat-petster/h.$SPECIES 
%
% OUTPUT 
%	dat-petster/testset.[SPECIES].mat
%		.e1	Size of training set
%		.e2	Size of test set
%		.E ((2*e) * 2) with e = e1 + e2
%			The test matrix.  The first e rows are the
%			positive test set; the last e rows are the
%			negative test set.  Within each e rows, the
%			first e1 are the training set, and the
%			following e2 are the test set. 
%

species = getenv('SPECIES');

% Number of pets
n = load(sprintf('dat-petster/n.%s', species)) 

% Number of households
h = load(sprintf('dat-petster/h.%s', species)) 

% (n*1) Household vector
household = load(sprintf('dat-petster/household.%s', species));
assert(size(household,1) == n);
assert(size(household,2) == 1); 

% (h*1) Number of pets per household
pph = sparse(household, 1, 1, h, 1); 
assert(size(pph,1) == h);
assert(size(pph,2) == 1); 
assert(sum(pph < 1) == 0); % Every household has at least one pet 

%
% Generate h pairs of pets in the same household
%

% Generate one positive test edge for each household with more than
% one pet.  Then generate the same number of pet pairs not in the
% same household. 

'pos'

E_pos = []; 

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

    E_pos = [ E_pos ; us(ii) , us(jj) ]; 
end

konect_timer_end(t); 

assert(size(E_pos,2) == 2);
e = size(E_pos,1)
assert(e == sum(pph ~= 1)); 

%
% Generate m pairs of pets not in the same household 
%

'neg'

% Numbers in first column are smaller than numbers in second column
E_neg = [];

% Upper-diagonal matrix of already-chosen elements 
A_neg = sparse(n,n); 

t = konect_timer(e);

while size(E_neg,1) < e

    t = konect_timer_tick(t, size(E_neg,1)); 

    u = randi(n);
    v = randi(n);
    if u > v
        tmp = u;
        u = v;
        v = tmp;
    end
    assert(u <= v); 
    if household(u) == household(v),  continue;  end;
    if A_neg(u,v) ~= 0,  continue;  end;
    E_neg = [ E_neg ; u , v ];
    A_neg(u,v) = 1; 
end

konect_timer_end(t); 

assert(size(E_neg,1) == e);
assert(size(E_neg,2) == 2); 

% Randomize order 
E_pos = E_pos(randperm(e),:);
E_neg = E_neg(randperm(e),:);

assert(size(E_pos,1) == e);
assert(size(E_pos,2) == 2); 
assert(size(E_neg,1) == e);
assert(size(E_neg,2) == 2); 

% Equal size for training and test set
e1 = round(e / 2);
e2 = e - e1;

%
% Save
%

E = [ E_pos ; E_neg ];
assert(size(E, 1) == 2 * e);
assert(size(E, 2) == 2); 

save(sprintf('dat-petster/testset.%s.mat', species), ...
     'e1', 'e2', 'E', ...
     '-v7.3');
