
function petster_assortativity_one(x, y, color)

N = 10000

assert(length(x) == length(y));
n = length(x)

if n > N
    ii = randperm(n);
    ii = ii(1:N); 
    x = x(ii);
    y = y(ii); 
end

% subplot(2, 3, i);  

plot(x, y, '.', 'Color', color, 'MarkerSize', 2);

%axis square;
