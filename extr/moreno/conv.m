
a = load('mjazz.dat');

s = norm(a - a')

[x y] = find(a);
i = x < y;
x = x(i);
y = y(i);

OUT = fopen('out.mjazz', 'w');
if OUT < 0, error('***'); end

fprintf(OUT, '%% sym unweighted\n'); 
fprintf(OUT, '%% %u %u %u\n', length(x), size(a,1), size(a,2)); 

fprintf(OUT, '%u %u\n', [x y]');

if 0 > fclose(OUT); error('***'); end
