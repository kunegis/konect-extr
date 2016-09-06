% -*-octave-*-
%
% Add edges to an adjacency matrix to make the graph connected.
%
% a3       spconvert-compatible n×3 matrix 
% a        adjacency matrix
% n        number of nodes
%
function [a_out] = connect(a3, a)

n = size(a,1);

component = 1:n;

i = 0;

while 1
  i = i+1;
  old_component = component;
  for j=1:size(a3,1)
    component(a3(j,1)) = min(component(a3(j,1)), component(a3(j,2)));
    component(a3(j,2)) = min(component(a3(j,1)), component(a3(j,2)));
  end
  if component == old_component, break, end
end

%component(1:20)

%sum(component == 1:n)
%i

%find(component == 1:n)

for u = find(component == 1:n)
  if u == 1, continue, end
  a(1,u) = 1;
end

a_out = a;
