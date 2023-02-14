function export_mass_spectrum(s, filename, pks = [])
	dir = fileparts(filename);
	if (!isempty(dir) && !isfolder(dir))
		mkdir(dir);
	endif
	f = fopen(filename, "w");
	cleanup = onCleanup(@() fclose(f));

	fdisp(f, "m/z[Th]	in[a.u.]	in_rel");
	if (isempty(pks))
		dlmwrite(f, [s.mz s.in s.inrel], "\t");
	else
		dlmwrite(f, [s.mz s.in s.inrel](pks,:), "\t");
	endif
endfunction
