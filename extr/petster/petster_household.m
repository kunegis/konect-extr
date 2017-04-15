%
% Generate household ID by pet.
%
% PARAMETERS 
% 	$SPECIES
%
% INPUT 
%	dat-petster/out.petster-[SPECIES]-friend 
%	dat-petster/out.petster-[SPECIES]-family
%	dat-petster/n.[SPECIES]
%
% OUTPUT 
% 	dat-petster/household.[SPECIES]
%		(n*1) Household ID for all pets 
%	dat-petster/h.[SPECIES]
%		(1*1) Number of households
%

species = getenv('SPECIES');

n = load(sprintf('dat-petster/n.%s', species))

T_friend = load(sprintf('dat-petster/out.petster-%s-friend', species));
T_family = load(sprintf('dat-petster/out.petster-%s-family', species));

A_family = sparse(T_family(:,1), T_family(:,2), 1, n, n); 

household = zeros(n, 1); 

% Transitive hull of A_family 
B = double((A_family + A_family' + speye(n)) ~= 0); 

while 1
    B_old = B;
    B = double(((B * B + B) ~= 0));
    nnz_B = nnz(B)
    if nnz(B) == nnz(B_old)
        break
    end
end

B_beg = full(B(1:10,1:10))

nnz_A_family = nnz(A_family + A_family)
nnz_B = nnz(B)

size_B = size(B)

maxid = max(B * spdiags((1:n)', [0], n, n), [], 2);       % Old household ID by pet ID
size_maxid = size(maxid)
maxid_beg = maxid(1:10)
maxid_u = unique(maxid); % List of unique old household IDs
size_maxid_u = size(maxid_u)
h = length(maxid_u)      % Number of households
hh = zeros(n,1);	 % Mapping of old household IDs to new
                         % household IDs
hh(maxid_u) = 1:h;
household = hh(maxid); 
size_household = size(household)

assert(length(household) == n);
assert(max(household) == h); 

%
% Save
%

OUT_HOUSEHOLD = fopen(sprintf('dat-petster/household.%s', species), 'w');
if OUT_HOUSEHOLD < 0,  error();  end
fprintf(OUT_HOUSEHOLD, '%u\n', household'); 
if fclose(OUT_HOUSEHOLD) < 0.  error();  end

OUT_H = fopen(sprintf('dat-petster/h.%s', species), 'w');
if OUT_H < 0,  error();  end
fprintf(OUT_H, '%u\n', h);
if fclose(OUT_H) < 0;  error();  end
