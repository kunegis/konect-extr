%
% Compute statistics over time. 
%
% INPUT 	
%	out.lqfb-temporal
%
% OUTPUT 
%	dat-lqfb/temporal.mat
%		.data	Struct by statistic name of column vector for
%			all statistic values
%		.statistics	Cell array of statistic names 
%		.t_all	Array of time points 
%

% Number of timepoints 
n_time = 100;

%    'uniquevolume' ; 
statistics = { ...
    'adds'; 'removes'; ...
    'avgdegreeasym'; 'reciprocity'; 'gini'; ...
    'clusco'; ...
    'coco'; ...
    'cocos'; ...
    'meandist' ...
             }; 

indexes = [ 1 1 3 1 1 1 1 1 1];

consts = konect_consts(); 

T = load('out.lqfb-temporal');
assert(size(T,2) == 4); 
size_T = size(T)

n = max(max(T(:,1:2)))

t_min = min(T(:,4))
t_max = max(T(:,4))

t_all = (t_min : (t_max - t_min) / (n_time - 1) : t_max)';

data = struct();

t = konect_timer(n_time); 

for j = 1 : length(statistics)
    statistic = statistics{j}
    data.(statistic) = []; 
end

for i = 1 : n_time
    i
    t = konect_timer_tick(t, i); 
    ii = T(:,4) <= t_all(i);
    A_i = sparse(T(ii,1), T(ii,2), T(ii,3), n, n); 
    size_A_i = size(A_i)
    nnz_A_i = nnz(A_i)

    for j = 1 : length(statistics)
        statistic = statistics{j}

        if strcmp(statistic, 'adds')

            if i == 1
                value = 0
            else
                value = sum(T(T(:,4) <= t_all(i) & T(:,4) > t_all(i-1),3) > 0);
            end

        elseif strcmp(statistic, 'removes')

            if i == 1
                value = 0
            else
                value = sum(T(T(:,4) <= t_all(i) & T(:,4) > t_all(i-1),3) < 0);
            end

        else
            value = konect_statistic(statistic, A_i, consts.ASYM, consts.DYNAMIC);
            value = value(indexes(j));
        end

        data.(statistic) = [ data.(statistic) ; value ]; 
    end
end

konect_timer_end(t); 

save('dat-lqfb/temporal.mat', 'data', 'statistics', 't_all', '-v7.3');
