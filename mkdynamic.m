%if (nargin!=1)
%	error ("Wrong number of arguments. Usage: octave -qf mkdynamic.m INPUTFILE");
%endif
function mkdynamic(infile)
 M = load(infile);  % (m*4), sorted by timestamp 
 n = max(max(M(:,1:2)));
 timestamps = unique(M(:,4));
 i=0;
 c={};
 for i=1:length(timestamps)
	time=timestamps(i,1);
	F=find(M(:,4)==time);
	fprintf('Iteration #%d\n',i);
	whos
	size_x=size(M(F,1))
	size_y=size(M(F,2))
	c{i} = sparse(M(F,1), M(F,2), 1, n, n);
 end

 for j=1:length(c)   
	cTime=timestamps(j,1);
	if (j==1)
		[a,b]=find(c{j});
		fprintf(1, '%u\t%u\t1\t%u\n', [a b (cTime * ones(length(a), 1))]'); 
	else
		D=c{j}-c{j-1};
		[a,b,z]=find(D);
		fprintf(1, '%u\t%u\t%d\t%u\n', [a b z (cTime * ones(length(a), 1))]'); 
	end;
 end;

