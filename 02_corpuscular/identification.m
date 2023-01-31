addpath octave;

function x = spectrum(x)
	x.s = mass_spectrum(x.mz, x.in);
endfunction

X = struct;
X(1).filename = "data/15eV_neznama_molekula.csv";
X(1).E = 15;

X(2).filename = "data/25eV_neznama_molekula.csv";
X(2).E = 25;

X(3).filename = "data/40eV_neznama_molekula.csv";
X(3).E = 40;

X(4).filename = "data/70eV_neznama_molekula.csv";
X(4).E = 70;

X = arrayfun(@load_data, X);
X = arrayfun(@spectrum, X);

pkintmax = max([[X.s].inmax], [], 2);
