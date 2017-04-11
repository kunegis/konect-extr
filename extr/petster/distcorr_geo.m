%
% Downloaded from http://www.mathworks.com/matlabcentral/fileexchange/39905-distance-correlation
%

%
% Copyright (c) 2013, Shen Liu
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
%
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in
%       the documentation and/or other materials provided with the distribution
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.
%

% This function calculates the distance correlation between x and y.
% Reference: http://en.wikipedia.org/wiki/Distance_correlation 
% Date: 18 Jan, 2013
% Author: Shen Liu (shen.liu@hotmail.com.au)

%
% Adapted by Jérôme Kunegis (2014) to work with geolocations.
%

%
% Compute the distance correlation between two paired sets of
% geolocations.  Each geolocation is given by a latitude/longitude
% pair. 
%
% PARAMETERS 
%	x,y	(n*2) First columns is latitude, second column is
%		longitude; both are in degrees 
%
% RESULTS 
%	rho	Distance correlation 
%	pvalue	The p-value (not implemented yet) 
%

function [rho pvalue] = distcorr_geo(x,y)

assert(size(x,2) == 2);
assert(size(y,2) == 2);
assert(size(x,1) == size(y,1));

% All data must be finite
assert(sum(sum(~isfinite(x))) == 0);
assert(sum(sum(~isfinite(y))) == 0);

n = size(x,1);

% If n is too large, sample to get smaller dataset. 

% Maximal number of points
N = 1000;

if n > N
    i = randperm(n);
    i = i(1:N);
    x = x(i,:);
    y = y(i,:);
    n = N; 
end

assert(size(x,2) == 2);
assert(size(y,2) == 2);
assert(size(x,1) == size(y,1));

% Convert to radians
x = x * pi / 180;
y = y * pi / 180;

% Calculate doubly centered distance matrices for x and y
a = acos(sin(x(:,1)) * sin(x(:,1))' + (cos(x(:,1)) * cos(x(:,1))') ...
         .* cos(x(:,2) * ones(1,n) - ones(n,1) * x(:,2)'));
b = acos(sin(y(:,1)) * sin(y(:,1))' + (cos(y(:,1)) * cos(y(:,1))') ...
         .* cos(y(:,2) * ones(1,n) - ones(n,1) * y(:,2)'));

% Multiply by radius of the earth in kilometers
a = a * 6371;
b = b * 6371;

%%% a = pdist2(x,x);
%%% b = pdist2(y,y);

mcol = mean(a);
mrow = mean(a,2);
ajbar = ones(size(mrow))*mcol;
akbar = mrow*ones(size(mcol));
abar = mean(mean(a))*ones(size(a));
A = a - ajbar - akbar + abar;

mcol = mean(b);
mrow = mean(b,2);
bjbar = ones(size(mrow))*mcol;
bkbar = mrow*ones(size(mcol));
bbar = mean(mean(b))*ones(size(b));
B = b - bjbar - bkbar + bbar;

% Calculate squared sample distance covariance and variances
dcov = sum(sum(A.*B))/(size(mrow,1)^2);

dvarx = sum(sum(A.*A))/(size(mrow,1)^2);
dvary = sum(sum(B.*B))/(size(mrow,1)^2);

% Calculate the distance correlation
rho = real(sqrt(dcov/sqrt(dvarx*dvary)));

%
% p-value calculation.  Based on the method found in MATHWORKS_R2009B/toolbox/stats/corr.m 
%

t = sign(rho) .* Inf
k = (abs(rho) < 1)
t(k) = rho(k) .* sqrt((n-2) ./ (1 - rho(k) .^ 2))
pvalue = 2 * tcdf(-abs(t), n - 2)
