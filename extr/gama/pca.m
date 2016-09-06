%
% INPUT FILES
%	rel.{pos,neg}
%
% OUPUT FILES
%	plot/pca.$type.eps
%

%% path(path, '../matlab'); 

n = 16; 

T_pos = load('rel.pos');
T_neg = load('rel.neg');

gama_pos = sparse(T_pos(:,1), T_pos(:,2), 1, n, n); 
gama_neg = sparse(T_neg(:,1), T_neg(:,2), 1, n, n); 

gama = full(gama_pos - gama_neg);

%
% A
% 

[u,d] = eig(gama); 
[s,i] = sort(-abs(diag(d)));
d = d(i,i); 
u = u(:,i); 

pca_one(gama_pos, gama_neg, u(:,1:2)); 
print('plot/pca.a.eps', '-depsc'); close all; 

%
% L
%

l = diag(sum(abs(gama))) - gama;
[u,d] = eig(l)
[s,i] = sort(-diag(pinv(d))); 
d = d(i,i); 
u = u(:,i); 

pca_one(gama_pos, gama_neg, u(:,1:2)); 
print('plot/pca.l.eps', '-depsc'); close all; 

%
% L
%

l = diag(sum(abs(gama))) - abs(gama);
[u,d] = eig(l)
[s,i] = sort(-diag(pinv(d))); 
d = d(i,i); 
u = u(:,i); 

pca_one(gama_pos, gama_neg, u(:,1:2)); 
print('plot/pca.m.eps', '-depsc'); close all; 
