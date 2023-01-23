pkg load report;

if (!exist("X", "var"))
	identification;
endif

for k = 1:numel(X)
	x = X(k);
	int = zeros(size(x.int));
	int(x.int > 0) = log10(x.int(x.int > 0));
	gp = gnuplotter;
	gp.load("../plotsettings.gp");
	gp.plot(x.m, int, "w l");
	gp.exec("\n\
		set yrange [3:6] \n\
		unset key \n\
	");
	gp.export(sprintf("plots/unknown-%d.tex", k), "epslatex", "size 16cm,6cm");
endfor

