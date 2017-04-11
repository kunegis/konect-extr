%
% Load a text file.  Returns a cell array containing all lines of the
% file as strings. 
%

function [ret] = readent(filename)

% Note:  It is *not* possible to do this with importdata(), as
% importdata() does not support empty lines [sic].  Also, fgetl() and
% fgets() both return -1 for empty lines, which is the same value
% they return for end-of-file condition. Also, feof() may return 0
% even though there is nothing more to read in the file (e.g. when
% the file is empty), and will return 1 even though there is more to
% read sometimes (e.g. before reading the last line of the file).  In
% conclusion, Matlab sucks in this regard. 

ret = textread(filename, '%s', 'delimiter', '\n', 'whitespace', '');
