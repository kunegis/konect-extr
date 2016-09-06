%
% Generate a random directed acyclic Erdős--Rényi graph.
%

nt = getenv('SIZE');
dt = getenv('DENSITY'); 
n = sscanf(nt, '%d'); 
d = sscanf(dt, '%d'); 

% The factor 2 is because we keep only half the edges. 
a = sprand(n, n, 2 * d / n); 

%a = triu(a); 

[x y] = find(a); 
i = x < y;
x = x(i);
y = y(i); 

OUT = fopen(sprintf('out.random-dag-%s-%s', nt, dt), 'w');

fprintf(OUT, '%% asym unweighted\n');
fprintf(OUT, '%d\t%d\n', [x y]');

if fclose(OUT), error 'fclose'; end; 

