% -*-octave-*-
function [map] = troll_eval(file, trolls, name, trust)
%
% Evaluate a trust measure against the actual troll vector
%

nn=6;

n=size(trust, 1);

[tops, top_userids] = sort(trust);

% Since we don't know the sign of the eigenvector we calculate both the biggest and smallest

xsum=0;
xsumi=0;

troll_total = sum(trolls);

troll_count = 0;

for u = 1:n
  ui = n-u+1;
  if trolls(top_userids(u)) == 1
    troll_count = troll_count + 1;
    xsum = xsum + troll_count / u;
    xsumi = xsumi + (troll_total - troll_count + 1) / ui;
  end;
%  sum = sum + trolls(top_userids(u)) / log(n - u + 2);
%  sumi = sumi + trolls(top_userids(u)) / log(n - ui + 2);
end;

xsum = xsum / troll_total;
xsumi = xsumi / troll_total;

if xsum < xsumi
  tmp = xsum;
  xsum = xsumi;
  xsumi = tmp;
else
  tops = tops(end:-1:1);  
  top_userids = top_userids(end:-1:1);  
  size(tops);
  size(top_userids);
end;

fprintf(file, '%7s: %f%%\n', name, xsum*100);
if 1
	  fprintf(file, '  Tops:\n');
  fprintf(file, '#%d:  %d\n', [top_userids((end-0):-1:(end-nn+1))'; tops((end-0):-1:(end-nn+1))']);
	  fprintf(file, '  Bottoms:\n');
	  fprintf(file, '#%d:  %g\n', [top_userids(1:nn)'; tops(1:nn)']);
		  fprintf(file, '\n');
end;

map = xsum;
