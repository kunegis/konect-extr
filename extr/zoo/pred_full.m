% -*-octave-*-
function [] = pred_full(file, a3_test, name, u, v, threshold)
%
% Evaluation prediction accuracy 
%
% file:  fd to write output to
% a3_test:  test matrix
% u, v:  rank-reduced form of prediction matrix (u * v)
%

k_max_ = size(u, 2);
n_test = size(a3_test, 1);

count_prediction_epsilon = 0;

for k = 1:k_max_
  sum_weights = 0;
  sum_squared = 0;


  for i=1:n_test
    % -1..+1
    prediction = u(a3_test(i, 1), 1:k) * v(1:k, a3_test(i, 2));
    if abs(prediction) < abs(threshold)
      count_prediction_epsilon = count_prediction_epsilon + 1;  
    end;
    weight = sign(a3_test(i, 3) * (prediction + threshold));
    sum_weights = sum_weights + weight;

  end;
  
  % RMSE
%  '======='
  aaa = sqrt(sum(u(:,1:k) .* u(:,1:k), 2));
  aaaa = aaa .^ -1;
  bbb = aaaa * ones(1,k);
  uu = u(:,1:k) .* bbb;
  

  vt = v';
  aaa = sqrt(sum(vt(:,1:k) .* vt(:,1:k), 2));
  aaaa = aaa .^ -1;
  bbb = aaaa * ones(1,k);
  vv = vt(:,1:k) .* bbb;

%  uu(1:5,:)
%  vv(1:5,:)

  pp = uu(a3_test(:,1), :) .* vv(a3_test(:,2), :);
%  pp(1:5,:)
  ppp = sum(pp,2);
%  ppp(1:30,:)
%  a3_test(1:30,1:3)
  di = a3_test(:,3) - ppp;
  rmse = sqrt(sum(di .* di) / n_test);

  fprintf(file, '%s\t %4d\t %g \t%4d\n', name, k, sum_weights / n_test, rmse);
end;

if threshold ~= 0
  fprintf(file, '#part_prediction_ε = %g\n', ... 
	  count_prediction_epsilon / n_test / k_max_);
end;

fprintf(file, '\n');

