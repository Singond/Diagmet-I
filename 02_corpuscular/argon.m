addpath octave;

data = read_eqp_csv("data/argon.csv");
mz = data(:,1);
in = data(:,2);
E = 70;
s = mass_spectrum(mz, in);
