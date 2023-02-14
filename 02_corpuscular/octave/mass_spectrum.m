function s = mass_spectrum(mz, in)
	s.mz = (1:ceil(max(mz)))';
	[~, idx] = histc(mz, [s.mz - 0.5; s.mz(end) + 0.5]);
	idx = max(idx, 1);
	s.in = accumarray(idx, in, [], @mean);
	s.inmax = accumarray(idx, in, [], @max);
	s.inrel = s.in ./ max(s.in);
endfunction
