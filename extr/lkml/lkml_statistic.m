%
% Compute a statistic.
%
% PARAMETERS 
%	$STATISTIC
%	$YEAR
%	$GROUP
%
% INPUT 
%	dat-lkml/out.lkml-reply
%	dat-lkml/ent.lkml-reply-type
%
% OUTPUT 
%	dat-lkml/statistic.$YEAR.$GROUP.$STATISTIC
%

statistic = getenv('STATISTIC');

year_text = getenv('YEAR'); 
[year, c] = sscanf(year_text, '%u')
if c ~= 1,  error();  end

group_text = getenv('GROUP');
group = group_text - '0'

T = load('dat-lkml/out.lkml-reply');
t = T(:,4);
T = T(:,1:2);

y = floor(t / 60 / 60 / 24 / 365.2424 + 1970);

i = (y == year);
T = T(i,:);
size_T = size(T)
assert(size(T,1) > 100); 

typ = load('dat-lkml/ent.lkml-reply-type');

n = length(typ) 

j = (typ == group); 
size_j = size(j)
assert(length(j) > 1); 
sum_j = sum(j)
assert(sum_j > 1); 

fh = str2func(sprintf('lkml_statistic_%s', statistic));

value = fh(n, T, j); 

assert(length(value) == 1); 
value = full(value);

save(sprintf('dat-lkml/statistic.%s.%s.%s', year_text, group_text, statistic), ...
     'value', '-ascii');

