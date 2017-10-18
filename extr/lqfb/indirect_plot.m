%
% Plot distributions of indirection delegation counts. 
%
% INPUT 
%	indirect
%
% OUTPUT 
% 	indirect.[a].eps
%

d = load('indirect'); 

konect_power_law_plot(d);

xlabel('Number of direct and indirect received delegations');
ylabel('Complementary cumulated frequency'); 

konect_print('indirect.a.eps'); 
