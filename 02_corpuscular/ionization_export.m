pkg load report;

ionization;

gp = gnuplotter();
gp.load("plotsettings.gp");
gp.exec("\n\
	set decimalsign '.' \n\
	set lmargin 8 \n\
	set rmargin 1.5 \n\
	set tmargin 2 \n\
	set xrange [15:20] \n\
	set xlabel '$\\en\\,[\\si{\\electronvolt}]$' \n\
	set ylabel 'intenzita $\\en\\,[\\si{\\arbu}]$' offset 0.5,0 \n\
	set key top left \n\
	set title '\\ce{Ar+}' \n\
");
gp.plot(ar1.E,    ar1.in,    "w l ls 1      t 'data'");
gp.plot(ar1.fitE, ar1.fitin, "w l ls 2 dt 2 t 'fit'");
gp.exec(sprintf("\n\
	set arrow from %f,%f rto character 0,2 ls 1 as 1 backhead \n\
	set label center at %f,%f offset character 0,3 '\\SI{%.2f}{\\electronvolt}' \n\
	",
	ar1.Ei, 0, ar1.Ei, 0, ar1.Ei));
gp.export("plots/ionization-1.tex", "epslatex", "size 8.4cm,7cm");

gp = gnuplotter();
gp.load("plotsettings.gp");
gp.exec("\n\
	set decimalsign '.' \n\
	set lmargin 8 \n\
	set rmargin 1.5 \n\
	set tmargin 2 \n\
	set xrange [40:60] \n\
	set xlabel '$\\en\\,[\\si{\\electronvolt}]$' \n\
	set ylabel 'intenzita $\\en\\,[\\si{\\arbu}]$' offset 0.5,0 \n\
	set key top left \n\
	set title '\\ce{Ar^2+}' \n\
");
gp.plot(ar2.E,    ar2.in,    "w l ls 1      t 'data'");
gp.plot(ar2.fitE, ar2.fitin, "w l ls 2 dt 2 t 'fit'");
gp.exec(sprintf("\n\
	set arrow from %f,%f rto character 0,2 ls 1 as 1 backhead \n\
	set label center at %f,%f offset character 0,3 '\\SI{%.2f}{\\electronvolt}' \n\
	",
	ar2.Ei, 0, ar2.Ei, 0, ar2.Ei));
gp.export("plots/ionization-2.tex", "epslatex", "size 8.4cm,7cm");
