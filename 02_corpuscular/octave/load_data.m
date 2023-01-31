function d = load_data(d)
	data = read_eqp_csv(d.filename);
	d.mz = data(:,1);
	d.in = data(:,2);
endfunction
