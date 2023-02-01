addpath octave;

data = read_eqp_csv("data/IonizacniEnergieArgon.csv");
ar1.E = data(:,1);
ar1.in = data(:,2);

data = read_eqp_csv("data/Ar++IonizacniEnergie.csv");
ar2.E = data(:,1);
ar2.in = data(:,2);

function x = threshold(x, fitrange)
	m = fitrange(1) < x.E & x.E < fitrange(2);
	p = polyfit(x.E(m), x.in(m), 2);
	r = roots(p);
	x.fitf = @(E) polyval(p, E);
	x.Ei = max(real(r));
	m2 = x.Ei < x.E;
	x.fitE = x.E(m2);
	x.fitin = polyval(p, x.E(m2));
end

ar1 = threshold(ar1, [16 18]);
ar2 = threshold(ar2, [45 60]);

printf("ionization threshold of Ar+    Ei = %.3f eV\n", ar1.Ei);
printf("ionization threshold of Ar2+   Ei = %.3f eV\n", ar2.Ei);
