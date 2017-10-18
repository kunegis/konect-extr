%
% Compute indirect distribution of delegations. 
%
% INPUT 
%	inu.lqfb-*
%
% OUTPUT 
%	indirect
%

names = {'Global', 'Area', 'Issue', 'Unit'};

data = load('out.lqfb-All');
n = max(max(data(:,1:2)))

D = sparse(n,n); 

for i = 1 : length(names)
    name = names{i}
    data = load(sprintf('inu.lqfb-%s', name));
    assert(size(data, 2) == 5); 
    data = data(:,1:4);
    topics = unique(data(:,4)); 

    for j = 1 : length(topics)
        topic = topics(j); 
        data_j = data(data(:,4) == j, 1:3);
        %        size_data_j = size(data_j)
        A = sparse(data_j(:,1), data_j(:,2), data_j(:,3), n, n); 
        assert(sum(sum(A < 0)) == 0); 
        
        % Potentiate until convergence
        B = A; 
        nzero = nnz(B); 
        while 1
            B_new = A * B;
            B = (B_new ~= 0) | B; 
            nzero_new = nnz(B);
            if nzero_new == nzero,  break;  end;
            nzero = nzero_new; 
        end

        % Logically add to matrix of indirect delegations. 
        D = D | B; 
    end
end

% sum up matrix of indirect delegations.
d = sum(D, 1)'; 

d = full(d); 

size_d = size(d)

% Save / plot 
OUT = fopen('indirect', 'w'); 
if OUT < 0,  error('fopen');  end; 
fprintf(OUT, '%u\n', d);
if fclose(OUT) < 0,   error('indirect');  end; 
%save('indirect', '-ascii', 'd');
