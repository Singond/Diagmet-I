pkg load report;

energy;

function plotpeak(X, species, name)
	gp = gnuplotter();
	gp.load("plotsettings.gp");
	gp.exec(sprintf("\n\
		set decimalsign '.' \n\
		set lmargin 6 \n\
		set rmargin 2 \n\
		set tmargin 2 \n\
		set xlabel '$\\en\\,[\\si{\\electronvolt}]$' \n\
		set ylabel 'intenzita $\\intens\\,[\\si{\\arbu}]$' \n\
		set key top left height 1 \n\
		set title '\\ce{%s}' \n\
		",
		species));
	for k = 1:numel(X)
		x = X(k);
		gp.plot(x.E, x.in.*1e-3, sprintf(
			"w l ls %d t '\\SI{%.1f}{\\pascal}'", k, x.p));
	endfor
	gp.export(sprintf("plots/plasma-%s.tex", name), "epslatex", "size 8cm,7cm");
endfunction

plotpeak(ar,  "Ar+",  "ar");
plotpeak(arh, "ArH+", "arh");
plotpeak(nn,  "N2+",  "nn");
