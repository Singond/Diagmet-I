identification;

for k = 1:numel(X)
	x = X(k);
	figure(k);
	clf;
	plot(x.m, x.int);
endfor
