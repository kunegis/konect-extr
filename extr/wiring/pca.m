% -*-octave-*-
%
% INPUT
%	rel.{pos,neg}
%
% OUPUT
%	plot/pca.[type].eps
%

path(path, '../matlab'); 

n = 16; 

wiring_pos = myspconvert(load('rel.pos'), n, n); 
wiring_neg = myspconvert(load('rel.neg'), n, n); 

wiring = full(wiring_pos - wiring_neg);

%
% A
% 
[u,d] = eig(wiring); 
[s,i] = sort(-abs(diag(d)));
d = d(i,i); 
u = u(:,i); 

pca_one(wiring_pos, wiring_neg, u(:,1:2)); 
print('plot/pca.a.eps', '-depsc'); close all; 

%
% L
%
l = diag(sum(abs(wiring))) - wiring;
[u,d] = eig(l); 
[s,i] = sort(-diag(pinv(d))); 
d = d(i,i); 
u = u(:,i); 

pca_one(wiring_pos, wiring_neg, u(:,1:2)); 
print('plot/pca.l.eps', '-depsc'); close all; 

%
% L
%
l = diag(sum(abs(wiring))) - abs(wiring);
[u,d] = eig(l)
[s,i] = sort(-diag(pinv(d))); 
d = d(i,i); 
u = u(:,i); 

pca_one(wiring_pos, wiring_neg, u(:,2:3)); 
print('plot/pca.m.eps', '-depsc'); close all; 

