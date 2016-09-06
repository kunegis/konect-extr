
statistics = load('statistics-dump'); 

[m n] = size(statistics); 

ret = statistics(:,2:3) ./ (statistics(:,1) * ones(1,2))

save('statistics-result', '-ascii', 'ret'); 
