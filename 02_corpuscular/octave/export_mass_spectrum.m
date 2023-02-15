function export_mass_spectrum(s, filename, pks = [])
	dir = fileparts(filename);
	if (!isempty(dir) && !isfolder(dir))
		mkdir(dir);
	endif
	f = fopen(filename, "w");
	cleanup = onCleanup(@() fclose(f));

	data = NA(numel(s(1).mz), 2 * numel(s) + 1);
	data(:,1) = s(1).mz;
	for k = 1:numel(s)
		data(:,2*k) = s(k).in;
		data(:,2*k + 1) = s(k).inrel;
	endfor

	fputs(f, "m/z[Th]");
	for k = 1:numel(s)
		fputs(f, "	in[a.u.]	in_rel");
	endfor
	fdisp(f, "");

	if (!isempty(pks))
		data = data(pks,:);
	endif

	dlmwrite(f, data, "\t");
endfunction
