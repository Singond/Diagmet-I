pkg load report;

residual;

gp = gnuplotter();
gp.load("../plotsettings.gp");
gp.load("massspec.gp");
gp.exec("\n\
	set xrange [10:60] \n\
	set yrange [1e2:1e5] \n\
");
in = max(in, 1);
gp.plot(mz, in, "w filledcurves");
xpos = s.mz;
ypos = s.inmax;
ypos(14) *= 1.5;
xpos(16) -= 0.2;
xpos(17) -= 0.2;
pks = [14:18 28 32 40 44 56];
for p = pks
	gp.exec(sprintf(
		"set label '%d' at %f,%f center offset 0,1",
		p, xpos(p), ypos(p)));
endfor
gp.export("plots/residual.tex", "epslatex", "size 16cm,8cm");

export_mass_spectrum(s, "results/residual.csv", pks);
