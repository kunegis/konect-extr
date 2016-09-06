%
% Generate the continuous Cat/Dog data.  The continuous cat/dog data
% does *not* have IDs that corespond to the IDs in the ENT files.
% (In fact there are no ENT files for CATDOG.)
%
% INPUT 
%	dat-petster/out.petster_orig-cat-friend
%	dat-petster/out.petster_orig-dog-friend
%	dat-petster/out.petster_orig-catdog-family
%
% OUTPUT 
%	dat-petster/out.petster-catdog-friend
%	dat-petster/out.petster-catdog-family 
%	dat-petster/n.catdog
%

T1c = load('dat-petster/out.petster_orig-cat-friend');
T1d = load('dat-petster/out.petster_orig-dog-friend');
T2  = load('dat-petster/out.petster_orig-catdog-family'); 

% All old IDs are set to 1. 
id = sparse([T1c(:,1); T1c(:,2); T1d(:,1); T1d(:,2); T2(:,1); T2(:,2)], 1, 1);
id = double(id ~= 0);

% Mapping from old ID to new ID
ii = find(id);
size_ii = size(ii)
id2(ii) = 1:nnz(id);
size_id2 = size(id2)

% Version of T with new IDs
size_x1c = size(id2(T1c(:,1)))
size_x1d = size(id2(T1d(:,1)))
G1 = [ id2(T1c(:,1))' , id2(T1c(:,2))' ; id2(T1d(:,1))' , id2(T1d(:,2))' ];
G2 = [ id2(T2(:,1))' , id2(T2(:,2))' ];

size_G1 = size(G1)
size_G2 = size(G2)

G1_beg = G1(1:30,:)
G2_beg = G2(1:30,:)

n = max(max(max(G1)), max(max(G2)))

%
% Make simple network
%

A1 = sparse(G1(:,1), G1(:,2), 1, n, n);
A1 = A1 + A1';
A1 = triu(A1);
A1 = (A1 ~= 0);
A1 = A1 - spdiags(diag(A1), [0], n, n); 
[x y z] = find(A1);
G1 = [x y];

A2 = sparse(G2(:,1), G2(:,2), 1, n, n);
A2 = A2 + A2';
A2 = triu(A2);
A2 = (A2 ~= 0);
assert(sum(diag(A2)) == 0);
[x y z] = find(A2);
G2 = [x y];

%
% Save
%

OUT1 = fopen('dat-petster/out.petster-catdog-friend', 'w')
if OUT1 < 0,  error;  end
fprintf(OUT1, '%% sym unweighted\n'); 
fprintf(OUT1, '%u\t%u\n', G1');
if fclose(OUT1) < 0,  error,  end;

OUT2 = fopen('dat-petster/out.petster-catdog-family', 'w')
if OUT2 < 0,  error;  end
fprintf(OUT2, '%u\t%u\n', G2');
if fclose(OUT2) < 0,  error,  end;

OUT_N = fopen('dat-petster/n.catdog', 'w');
if OUT_N < 0,  error();  end
fprintf(OUT_N, '%u\n', n);
if fclose(OUT_N) < 0;  end
