addpath octave;

data = read_eqp_csv("data/ar-discharge_ions_ms.csv");
mz = data(:,1);
in = data(:,2);
E = 70;
s = mass_spectrum(mz, in);
