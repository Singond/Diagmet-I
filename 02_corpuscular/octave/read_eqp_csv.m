function [data, meta] = read_eqp_csv(file)
	if (ischar(file))
		filename = file;
		[f, fmsg] = fopen(filename, "r", "ieee-le");
		if (f == -1)
			error("read_princeton_spe: Error reading %s: %s", filename, fmsg);
		endif
		cleanup = onCleanup(@() fclose(f));
	elseif (is_valid_file_id(file))
		filename = "stream";
		f = file;
	else
		print_usage;
	end
	[~, name, ext] = fileparts(filename);
	basename = [name ext];

	data = csvread(f, 42, 3);
endfunction
