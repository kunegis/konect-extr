
a = load('gama-pos.dat');
b = load('gama-neg.dat'); 

c = a - b;

[x y z] = find(c);

i = x < y;
x = x(i);
y = y(i);
z = z(i); 

OUT = fopen('out.ucidata-gama', 'w');
if OUT < 0, error('***'); end

fprintf(OUT, '%% sym signed\n'); 
fprintf(OUT, '%% %u %u %u\n', length(x), size(c,1), size(c,2)); 

fprintf(OUT, '%u\t%u\t%d\n', [x y z]');

if 0 > fclose(OUT); error('***'); end
