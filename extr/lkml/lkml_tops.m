%
% Find the top users according to a given feature, by group. 
% 
% PARAMETERS 
%	$FEATURE 
%	$GROUP
%
% INPUT 
%	dat-lkml/feature.$FEATURE
%	dat-lkml/ent.lkml-reply-type
%	dat-lkml/ent.lkml-reply-domain
%
% OUTPUT 
%	dat-lkml/tops.$FEATURE.$GROUP
%

feature = getenv('FEATURE');
group_text = getenv('GROUP');
[group c] = sscanf(group_text, '%u');  if c ~= 1,  error();  end

feat = load(sprintf('dat-lkml/feature.%s', feature));
typ = load('dat-lkml/ent.lkml-reply-type');
domain = load('dat-lkml/ent.lkml-reply-domain');

%
% Domains of the top users
%

[tmp ii] = sort(feat, 'descend');
jj = (typ == group);

jj_ii = jj(ii);
domain_ii = domain(ii);

d = domain_ii(jj_ii); 
d = d(1:10); 

OUT = fopen(sprintf('dat-lkml/tops.%s.%s', feature, group_text), 'w');
if OUT < 0,  error();  end
fprintf(OUT, '%u\n', d);
if fclose(OUT) < 0,  error();  end

%
% Top domains by mean value
%

