%
% INPUT FILES
%	out.sampson.in
%
% OUTPUT FILES
%	out.sampson.out
%

T = load('out.sampson.in');

A = sparse(T(:,1), T(:,2), T(:,3)); 
B = sparse(T(:,1), T(:,2), 1); 

OUT = fopen('out.sampson.out', 'w');
if OUT < 0,  error('fopen');  end;

[x y z] = find(B); 

for i = 1 : length(x)
    fprintf(OUT, '%u\t%u\t%u\n', x(i), y(i), sign(A(x(i), y(i)))); 
end

if fclose(OUT) < 0,  error('fclose');  end;
