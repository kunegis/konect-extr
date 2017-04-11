%
% Compute the decomposition of the friendship matrix. 
%
% PARAMETERS 
%	$SPECIES
%
% INPUT 
%	dat-petster/out.petster-$SPECIES-friend
%	dat-petster/n.$SPECIES
%
% OUTPUT 
%	dat-petster/decomposition.$SPECIES.mat
%	.r
%	.U
%	.D
%

r = 250;

species = getenv('SPECIES');

consts = konect_consts(); 
opts.disp = 2; 

n = load(sprintf('dat-petster/n.%s', species));

T = load(sprintf('dat-petster/out.petster-%s-friend', species));
assert(size(T,2) == 2);

A = sparse(T(:,1), T(:,2), 1, n, n);

[U D] = konect_decomposition('sym', A, r, consts.ASYM, consts.UNWEIGHTED, opts); 

dd = diag(D)'

save(sprintf('dat-petster/decomposition.%s.mat', species), ...
     'r', 'U', 'D', ...
     '-v7.3'); 

