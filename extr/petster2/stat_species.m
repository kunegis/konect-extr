%
% Basic statistics.
%
% PARAMETERS 
%	$SPECIES 
%
% INPUT 
%	dat-petster/out.petster-$SPECIES-friend 
%	dat-petster/out.petster-$SPECIES-family
%
% OUTPUT 
%	dat-petster/stat.$SPECIES  Text, each line one statistic:
%		[1] Number of friendships
%

species = getenv('SPECIES') 

T1 = load(sprintf('dat-petster/out.petster-%s-friend', species));
T2 = load(sprintf('dat-petster/out.petster-%s-family', species));

assert(size(T1,2) == 2);
assert(size(T2,2) == 2);

m = size(T1, 1) 

OUT = fopen(sprintf('dat-petster/stat.%s', species), 'w');
if OUT < 0,  error('fopen');  end;
fprintf(OUT, '%u\n', m); 
if fclose(OUT) < 0,  error('fclose');  end;
