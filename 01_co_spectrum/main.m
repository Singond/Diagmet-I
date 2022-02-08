c = 299792458;       # [m/s]
h = 6.63e-34;        # [SI]

B.ome = 2112.7*1e2;  # [m-1]
B.omexe = 15.2*1e2;  # [m-1]
B.B = 1.961*1e2;     # [m-1]
B.ae = 0.026*1e2;    # [m-1]
B.De = 7.1e-4;       # [m-1]

A.ome = 1518.2*1e2;  # [m-1]
A.omexe = 19.4*1e2;  # [m-1]
A.B = 1.611*1e2;     # [m-1]
A.ae = 0.023*1e2;    # [m-1]
A.De = 7.33e-4;      # [m-1]

v = (0:10)';
R = 0:10;

B.Ev = h*c * (B.ome.*(v + 0.5) - B.omexe.*(v + 0.5).^2);
B.Bv = B.B - B.ae.*(v + 0.5);
B.Er = h*c * (B.Bv .* R .* (R + 1) - B.De .* (R .* (R + 1)).^2);
B.E = B.Ev + B.Er;

A.Ev = h*c * (A.ome.*(v + 0.5) - A.omexe.*(v + 0.5).^2);
A.Bv = A.B - A.ae.*(v + 0.5);
A.Er = h*c * (A.Bv .* R .* (R + 1) - A.De .* (R .* (R + 1)).^2);
A.E = A.Ev + A.Er;