%
% Generate a random preferential-attachment graph, a.k.a. a
% Barabási--Albert graph.  
%
% PARAMETERS
%	$SIZE
%	$DENSITY
%
% OUTPUT
%	out.random-prefatt-$SIZE-$DENSITY
%

nt = getenv('SIZE');
dt = getenv('DENSITY'); 
n = sscanf(nt, '%d'); 
d = sscanf(dt, '%d'); 

a = ones(d+1, d+1) - eye(d+1);
a = sparse(a); 

for i = d+2 : n
  if mod(i, 100) == 0
    fprintf(1, '%d / %d\n', i, n); 
  end
  a(i,i) = 0; 
  count = 0; 
  degrees = sum(a, 2);
  degrees = degrees / sum(degrees);
  degrees_sum = cumsum(degrees);
  while count < d
    r = rand; 
    for j = 1 : i-1
      if degrees_sum(j) > r
        if a(i,j) == 0
          a(i,j) = 1;
          count = count + 1; 
        end
        break; 
      end
    end    
  end
end

[x y] = find(a); 

OUT = fopen(sprintf('out.random-prefatt-%s-%s', nt, dt), 'w');

fprintf(OUT, '%% asym unweighted\n');
fprintf(OUT, '%d\t%d\n', [x y]');

if fclose(OUT), error 'fclose'; end; 
