pkg load report;

if (!exist("X", "var"))
	identification;
endif

for k = 1:numel(X)
	x = X(k);
	int = max(real(log10(x.in)), 1);
	gp = gnuplotter;
	gp.load("../plotsettings.gp");
	gp.plot(x.mz, int, "w l");
	gp.exec("\n\
		set yrange [3:6] \n\
		unset key \n\
	");
	gp.export(sprintf("plots/unknown-%d.tex", k), "epslatex", "size 16cm,6cm");
endfor

gp = gnuplotter();
gp.load("../plotsettings.gp");
for k = numel(X):-1:1
	x = X(k);
	int = max(x.in, 1);
	gp.plot(x.mz, int, sprintf(
		"w filledcurves t '\\SI{%d}{\\electronvolt}'", x.E));
	gp.exec("\n\
		set decimalsign '.' \n\
		set lmargin 2 \n\
		set rmargin 1 \n\
		set xrange [10:60] \n\
		set xlabel '$\\mz\\,[\\si{\\thomson}]$' \n\
		set log y \n\
		set format y '\\num[print-unity-mantissa=false]{%.0e}' \n\
		set yrange [1000:1e6] \n\
		set key top left height 1 width 1 \n\
	");
endfor
xpos = X(1).s.mz;
xpos(26) -= 0.1;
xpos(27) -= 0.1;
xpos(29) += 0.2;
xpos(57) += 0.2;
ypos = pkintmax;
ypos(42) *= 1.5;
for p = [18 26 27 28 29 30 32 39 41 42 52 54 56 57];
	gp.exec(sprintf(
		"set label '%d' at %f,%f center offset 0,1",
		p, xpos(p), ypos(p)));
endfor
gp.export(sprintf("plots/unknown-all.tex", k), "epslatex", "size 16cm,8cm");
