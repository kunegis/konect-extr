%
% Plot distribution of join age.
%
% PARAMETERS 
%	$SPECIES
%
% INPUT 
%	dat-petster/ent.petster-$SPECIES.joinage
%
% OUTPUT 
% 	plot-petster/joinage.a.$SPECIES.eps
%

species = getenv('SPECIES');

joinage = load(sprintf('dat-petster/ent.petster-%s.joinage', species));

joinage = joinage(find(isfinite(joinage))); 

hist(joinage, 100);

konect_print(sprintf('plot-petster/joinage.a.%s.eps', species));
