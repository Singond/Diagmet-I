addpath octave;

function d = load_data(d)
	data = read_eqp_csv(d.filename);
	d.m = data(:,1);
	d.int = data(:,2);
endfunction

function x = spectrum(x)
	x.pkm = (1:ceil(max(x.m)))';
	[~, idx] = histc(x.m, [x.pkm - 0.5; x.pkm(end) + 0.5]);
	x.pkint = accumarray(idx, x.int, [], @mean);
	x.pkintmax = accumarray(idx, x.int, [], @max);
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

pkintmax = max([X.pkintmax], [], 2);
