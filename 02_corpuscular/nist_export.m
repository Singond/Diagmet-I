pkg load report;

f = fopen("data/nist/cyclopropylamine.jdx");
fskipl(f, 25);
data = fscanf(f, "%f,%f", [2, Inf]);
mz = data(1,:)';
int = data(2,:)';

gp = gnuplotter();
gp.load("../plotsettings.gp");
gp.load("massspec.gp");
gp.plot(mz, int, "w boxes");
gp.exec("\n\
	set boxwidth 0.8 \n\
	set style fill solid \n\
	set xrange [10:60] \n\
	set yrange [10:1e4] \n\
");
gp.export("plots/cyclopropylamine-nist.tex", "epslatex", "size 16cm,8cm");
