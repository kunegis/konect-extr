
A = load('ucidata-zachary.dat');

s = norm(A - A')

[x y] = find(A);
i = x < y;
x = x(i);
y = y(i);

OUT = fopen('out.ucidata-zachary', 'w');
if OUT < 0, error('***'); end

fprintf(OUT, '%% sym unweighted\n'); 
fprintf(OUT, '%% %u %u %u\n', length(x), size(A,1), size(A,2)); 

fprintf(OUT, '%u %u\n', [x y]');

if 0 > fclose(OUT); error('***'); end
