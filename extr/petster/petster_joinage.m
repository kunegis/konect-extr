% 
% Generate the join age data.  NaN when either of the birthdate or
% join date is unknown. 
%
% PARAMETERS 
%	$SPECIES 
%
% INPUT 
%	dat-petster/ent.petster-$SPECIES.birthday
%	dat-petster/ent.petster-$SPECIES.joined
% 
% OUTPUT 
% 	dat-petster/ent.petster-$SPECIES.joinage
%		The join age or NaN when not known 
%

species = getenv('SPECIES'); 

birthday = load(sprintf('dat-petster/ent.petster-%s.birthday', species));
joined   = load(sprintf('dat-petster/ent.petster-%s.joined'  , species));

joinage = joined - birthday;

joinage(find(birthday == 0)) = NaN;
joinage(find(joined == 0)) = NaN; 

save(sprintf('dat-petster/ent.petster-%s.joinage', species), 'joinage', '-ascii');
