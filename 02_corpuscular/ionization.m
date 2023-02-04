addpath octave;

ar1 = load_data("data/IonizacniEnergieArgon.csv", "energy");
ar2 = load_data("data/Ar++IonizacniEnergie.csv", "energy");

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
