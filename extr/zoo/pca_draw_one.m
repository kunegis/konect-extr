% -*-octave-*-
%
% Draw one PCA plot. 
%
% PARAMETERS
%	name	Name of the variant
%	u	(n×k) Embedding to draw
%	trolls	Troll list
%

function pca_draw_one(name, u, trolls)

k = size(u,2)

%
% Without trolls
%
[min_x max_x] = minmax(u(:,1)); 
[min_y max_y] = minmax(u(:,2)); 

plot(u(:,1), u(:,2), '.'); 

axis([min_x max_x min_y max_y]);   
print(sprintf('plot/pca.%s.eps', name), '-depsc'); close all;

%
% With trolls
%
for i = 1:2:(k-1)
	hold on; 
	plot(u(:,i), u(:,i+1), '.'); 
	plot(u(trolls,i), u(trolls,i+1), 'or'); 
	[min_x max_x] = minmax(u(:,i)); 
	[min_y max_y] = minmax(u(:,i+1)); 
	axis([min_x max_x min_y max_y]);   
	legend('user', 'troll'); 
	title(['PCA of the Slashdot Zoo with method ' name]); 
	xlabel(sprintf('x_%d', i));
	ylabel(sprintf('y_%d', i+1)); 
	print(sprintf('plot/pca.%s.%d.trolls.eps', name, i), '-depsc'); close all;
end

%
% Minimal and maximal numbers, cutting the extreme points. 
%
function [min_w, max_w] = minmax(ww)

  % number of std. devs. to show 
  k = 14.0;

  % amount of points to cut
  alpha = .06;   

  % use the L1 deviation instead of the standard deviation
  ENABLE_L1 = 0;  

  % cut ALPHA points from each side
  ENABLE_CUT = 1;

  w = ww;

  if ENABLE_CUT
    n = size(w,1);
    w = sort(w);
    w = w(round(alpha * n):round((1-alpha) * n));
  end;

  mean_w = mean(w);

  if ENABLE_L1
    std_w  = mean(abs(w - mean_w));
  else
    std_w  = std(w,1);
  end;

  min_w = mean_w - k * std_w;
  max_w = mean_w + k * std_w;

end

end
