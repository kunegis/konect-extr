% -*-octave-*-
function [c_vector, c] = clusco_singlw(file, a, name)
%
% Calculate clustering coefficient of graph a
%
% OUTPUT:
%    c_vector:   user-vector giving the clustering coefficient per user.
%    c:    overall coefficient
%

sum_pairs = 0;
sum_count = 0;
usum_pairs = 0;

n = size(a, 1)

c_vector = zeros(n, 1);

for u = 1:n
  ao = a(u, :)';
  ai = a(:, u);
  
  nebs_op = find(ao > 0);
  nebs_on = find(ao < 0);
  nebs_ip = find(ai > 0);
  nebs_in = find(ai < 0);
  a_pp = a(nebs_ip, nebs_op);
  a_pn = a(nebs_ip, nebs_on);
  a_np = a(nebs_in, nebs_op);
  a_nn = a(nebs_in, nebs_on);

  user_count = sum(sum(a_pp)) - sum(sum(a_pn)) - sum(sum(a_pn)) + sum(sum(a_nn));
  user_pairs = (size(nebs_ip, 1) + size(nebs_in, 1)) * (size(nebs_op, 1) + size(nebs_on, 1)) - sum((ai ~= 0) & (ao ~= 0));
%size(nebs, 1) * (size(nebs, 1) - 1);

%  if user_count > user_pairs
%  nebs
%  an
%  an ~= 0
%  end;
  
  sum_count = sum_count + user_count;
  sum_pairs = sum_pairs + user_pairs;

  if user_pairs ~= 0
    c_vector(u) = user_count / user_pairs;
%    fprintf(1, '(%d %d %d %d) %d / %d %g\n', ...
%    size(nebs_op, 1), size(nebs_on, 1), size(nebs_ip, 1), size(nebs_in, 1), ...
%    full(user_count), full(user_pairs), full(user_count/user_pairs)); 
    usum_pairs = usum_pairs + user_count / user_pairs; 
  end;

  if mod(u, 753) == 0
    fprintf(1, '# %d  ~ %g\n', u, sum_count / sum_pairs); 
  end;
end;

c = sum_count / sum_pairs;

fprintf(file, 'Clustering coefficient %s = %f  (alt = %f)\n', ...
	name, c, usum_pairs / n);


