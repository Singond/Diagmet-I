addpath octave;

function d = load_data(filename)
	d = struct();
	data = read_eqp_csv(filename);
	d.m = data(:,1);
	d.int = data(:,2);
endfunction

X = struct;
X(1) = load_data("data/15eV_neznama_molekula.csv");
X(2) = load_data("data/25eV_neznama_molekula.csv");
X(3) = load_data("data/40eV_neznama_molekula.csv");
X(4) = load_data("data/70eV_neznama_molekula.csv");
