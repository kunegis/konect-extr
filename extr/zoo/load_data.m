% -*-octave-*-
%
% Load matrices 
%

function [a3_training, a, a3_test, n] = load_data()

a3_training = load('out.training');
a3_test = load('out.test');
a = spconvert(a3_training);
[n, nr] = size(a);
n = max(n, nr);
a(n, n)= 0; % no problem because on diagonal

