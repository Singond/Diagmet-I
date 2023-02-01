ionization;

co = get(gca, "colororder");

figure(1);
title("Ionization energies");
plot(
	ar1.E, ar1.in, "color", co(1,:),
	ar1.fitE, ar1.fitin, "--", "color", co(1,:),
	ar1.Ei, 0, "d", "color", co(1,:),
	ar2.E, ar2.in, "color", co(2,:),
	ar2.fitE, ar2.fitin, "--", "color", co(2,:),
	ar2.Ei, 0, "d", "color", co(2,:)
);
