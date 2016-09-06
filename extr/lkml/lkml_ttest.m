%
% Perform the statistical tests.  Actually not a t-test but a
% "Mann--Whitney U test". 
%
% FEATURES 
%	degree
%	indegree
%	outdegree
%	degreediff
%	pagerank
%
% INPUT 
%	dat-lkml/out.lkml-reply
%	dat-lkml/ent.lkml-reply-type
%	dat-lkml/n
%	dat-lkml/feature.pagerank
%
% OUTPUT 
%	dat-lkml/ttest
%

labels = lkml_labels(); 

alpha = 0.05; 

T = load('dat-lkml/out.lkml-reply');
typ = load('dat-lkml/ent.lkml-reply-type');
n = load('dat-lkml/n')
pagerank = load('dat-lkml/feature.pagerank'); 

k = max(typ)

% By feature name, a (n*1) vector of node features
feat = struct(); 

feat.degree     = sparse([T(:,1); T(:,2)], 1, 1, n, 1);
feat.indegree   = sparse( T(:,2),          1, 1, n, 1);
feat.outdegree  = sparse( T(:,1),          1, 1, n, 1);
feat.degreediff = feat.indegree - feat.outdegree;
feat.pagerank   = pagerank;

features = fields(feat);

OUT = fopen('dat-lkml/ttest', 'w');
if OUT < 0,  error();  end

for i = 1 : length(features)
    
    groups = {}; 

    for j1 = 1 : k

        vals = feat.(features{i});

        groups{j1} = vals(typ == j1); 

        %%% Does not make sense
        % % Remove entries with minimal PageRank
        % if strcmp(features{i}, 'pagerank') 
        %     gg = groups{j1};
        %     groups{j1} = gg(gg ~= min(gg)); 
        % end

        for j2 = 1 : j1 - 1

            [p h stats] = ranksum(groups{j1}, groups{j2})

            if p < alpha
                description = 'SIGNIFICANT, THEY ARE REALLY DIFFERENT';
            else
                description = 'NOT SIGNIFICANT, THEY ARE THE SAME'; 
            end

            fprintf(OUT, '%s:  %s vs %s\n', features{i}, labels{j2}, labels{j1}); 
            fprintf(OUT, '%s\n', description); 
            fprintf(OUT, '\tp = %f\n', p);
            fprintf(OUT, '\th = %f\n', h);
            fprintf(OUT, '\tzval = %f\n', stats.zval);
            fprintf(OUT, '\tranksum = %f\n', stats.ranksum);
            fprintf(OUT, '\tsizes = %u, %u\n', length(groups{j2}), length(groups{j1})); 
            fprintf(OUT, '\tmeans = %g, %g\n', full(mean(groups{j2})), full(mean(groups{j1}))); 

            fprintf(OUT, '\n'); 

        end
    end
end

if fclose(OUT) < 0,  error();  end

