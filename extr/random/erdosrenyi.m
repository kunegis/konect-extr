%
% Generate an Erdős--Rényi random graph
%

nt = getenv('SIZE');
dt = getenv('DENSITY');
n = sscanf(nt, '%d'); 
d = sscanf(dt, '%d'); 

% The factor 2 is because we symmetrize later
a = sprand(n, n, d / n / 2); 

a = a + a';

[x y] = find(a); 

i = find(x > y); 

x = x(i);
y = y(i);

OUT = fopen(sprintf('out.random-erdosrenyi-%s-%s', nt, dt), 'w');

fprintf(OUT, '%% sym unweighted\n');
fprintf(OUT, '%d\t%d\n', [y x]');

if fclose(OUT), error 'fclose'; end; 
