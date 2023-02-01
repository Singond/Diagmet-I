pkg load report;

residual;

gp = gnuplotter();
gp.load("../plotsettings.gp");
gp.exec("\n\
	set decimalsign '.' \n\
	set lmargin 2 \n\
	set rmargin 1 \n\
	set xrange [10:60] \n\
	set xlabel '$\\mz\\,[\\si{\\thomson}]$' \n\
	set log y \n\
	set format y '\\num[print-unity-mantissa=false]{%.0e}' \n\
	set yrange [1e2:1e5] \n\
	unset key \n\
");
in = max(in, 1);
gp.plot(mz, in, "w filledcurves");
xpos = s.mz;
ypos = s.inmax;
ypos(14) *= 1.5;
xpos(16) -= 0.2;
xpos(17) -= 0.2;
for p = [14:18 28 32 40 44 56];
	gp.exec(sprintf(
		"set label '%d' at %f,%f center offset 0,1",
		p, xpos(p), ypos(p)));
endfor
gp.export("plots/residual.tex", "epslatex", "size 16cm,8cm");
