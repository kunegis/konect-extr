% -*-octave-*-
function [] = pred_sparse(file, a3_test, name, b)
%
% Evaluation using a sparse matrix.
%
% b is a sparse matrix that contains predictions.
%
% Evidently, methods evaluated by this function cannot be very
% sophisticated, because they give predictions only for a sparse
% subset of all user pairs. 
%

sum_weights = 0;

for i = 1:size(a3_test, 1)
  prediction = b(a3_test(i, 1), a3_test(i, 2));
  if prediction < 0
    prediction = -1;
  else
    prediction = +1;
  end;
  weight = sign(a3_test(i, 3) * prediction);
  sum_weights = sum_weights + weight; 
end;

fprintf(file, '# %s\t %g\n', name, sum_weights / size(a3_test, 1));
