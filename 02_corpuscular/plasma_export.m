pkg load report;

plasma;

gp = gnuplotter();
gp.load("../plotsettings.gp");
gp.load("massspec.gp");
gp.exec("\n\
	set xrange [0:85] \n\
	set yrange [1e2:3e6] \n\
");
in = max(in, 1);
gp.plot(mz, in, "w filledcurves above y1=0");
xpos = s.mz;
ypos = s.inmax;
xpos(17) -= 0.5;
ypos(18) *= 1.5;
xpos(19) += 0.5;
xpos(29) += 0.5;
xpos(39) -= 0.5;
xpos(41) += 0.5;
ypos(44) *= 1.2;
xpos(45) += 0.5;
ypos(45) /= 1.2;
for p = [1 17:19 28 29 32 36 38 40 41 44 45 80];
	gp.exec(sprintf(
		"set label '%d' at %f,%f center offset 0,1",
		p, xpos(p), ypos(p)));
endfor
gp.export("plots/plasma.tex", "epslatex", "size 16cm,8cm");
