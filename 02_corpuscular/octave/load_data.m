function d = load_data(from, type)
	if (isstruct(from))
		src = from.filename;
		d = from;
	elseif (ischar(from) || is_valid_file_id(from))
		src = from;
		d = struct;
	end

	data = read_eqp_csv(src);
	if (nargin < 2 || isempty(type) || strcmp(type, "mass"))
		d.mz = data(:,1);
		d.in = data(:,2);
	elseif (strcmp(type, "energy"))
		d.E = data(:,1);
		d.in = data(:,2);
	else
		error("load_data: TYPE must be one of 'mass' or 'energy'");
	endif
endfunction
