global c = 299792458;  # Speed of light in vacuum [m/s]
global h = 6.63e-34;   # Planck constant [J*s]

# The upper state: B1Sigma+
B.ome = 2112.7*1e2;    # [m-1]
B.omexe = 15.2*1e2;    # [m-1]
B.B = 1.961*1e2;       # [m-1]
B.ae = 0.026*1e2;      # [m-1]
B.De = 7.1e-4;         # [m-1]

# The lower state: A1Pi
A.ome = 1518.2*1e2;    # [m-1]
A.omexe = 19.4*1e2;    # [m-1]
A.B = 1.611*1e2;       # [m-1]
A.ae = 0.023*1e2;      # [m-1]
A.De = 7.33e-4;        # [m-1]

v = (0:10)';           # Vibrational numbers
R = 0:10;              # Rotational numbers

function s = generate_levels(s, v, R)
	global c
	global h
	s.Ev = h*c * (s.ome.*(v + 0.5) - s.omexe.*(v + 0.5).^2);
	s.Bv = s.B - s.ae.*(v + 0.5);
	s.Er = h*c * (s.Bv .* R .* (R + 1) - s.De .* (R .* (R + 1)).^2);
	s.E = s.Ev + s.Er;
endfunction

B = generate_levels(B, v, R);
A = generate_levels(A, v, R);
