%# -*-octave-*-
%# 
%# Basic evaluation
%#


function [] = eval_basic(file, a3_test)

fprintf (file, '#a 1   %g\n\n', sum(a3_test(:, 3)) / size(a3_test, 1));
