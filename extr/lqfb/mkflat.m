%
% PARAMETERS 
%	$NAME
%
% INPUT 
%	out.lqfb-[NAME]
%
% OUTPUT 
%	out.flat-lqfb-[NAME]
%

name = getenv('NAME')

T = load(sprintf('out.lqfb-%s', name)); 

n = max(max(T(:,1:2)))

A = sparse(T(:,1), T(:,2), 1, n, n);

A = (A ~= 0);

[x y z] = find(A);

T = [x y];

OUT = fopen(sprintf('out.flat-lqfb-%s', name), 'w');
if OUT < 0,  error();  end
fprintf(OUT, '%u\t%u\n', T');
if fclose(OUT) < 0,  error();  end



