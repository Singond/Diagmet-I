pkg load report;

f = fopen("data/nist/cyclopropylamine.jdx");
fskipl(f, 25);
data = fscanf(f, "%f,%f", [2, Inf]);
mz = data(1,:)';
int = data(2,:)';

gp = gnuplotter();
gp.load("../plotsettings.gp");
gp.plot(mz, int, "w boxes");
gp.exec("\n\
	set boxwidth 0.8 \n\
	set style fill solid \n\
	set decimalsign '.' \n\
	set lmargin 2 \n\
	set rmargin 1 \n\
	set xrange [10:60] \n\
	set xlabel '$\\mz\\,[\\si{\\thomson}]$' \n\
	set log y \n\
	set format y '\\num[print-unity-mantissa=false]{%.0e}' \n\
	set yrange [10:1e4] \n\
	unset key \n\
");
gp.export("plots/cyclopropylamine-nist.tex", "epslatex", "size 16cm,8cm");
