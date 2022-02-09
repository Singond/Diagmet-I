## Copyright 2022 Lukas Vrana, Jan Slany, Radek Hornak

global c = 299792458;     # Speed of light in vacuum [m/s]
global h = 6.626070e-34;  # Planck constant [J*s]
global k = 1.380649e-23;  # Boltzmann constant [J/K]
global ec = 1.60218e-19;  # Elementary charge [C]

Tv = 2000;                # Vibrational temperature [K]
Tr = 300;                 # Rotational temperature [K]

# The upper state: B1Sigma+
B.ome = 2112.7*1e2;       # [m-1]
B.omexe = 15.2*1e2;       # [m-1]
B.B = 1.961*1e2;          # [m-1]
B.ae = 0.026*1e2;         # [m-1]
B.De = 7.1e-4;            # [m-1]

# The lower state: A1Pi
A.ome = 1518.2*1e2;       # [m-1]
A.omexe = 19.4*1e2;       # [m-1]
A.B = 1.611*1e2;          # [m-1]
A.ae = 0.023*1e2;         # [m-1]
A.De = 7.33e-4;           # [m-1]

v = (0:10)';              # Vibrational numbers
R = 0:10;                 # Rotational numbers

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

## Generate allowable transitions

## Transitions in v
v2 = repelem(v, length(v));
v1 = repmat(v, length(v), 1);

## Transitions in R
R2 = repelem(R', 3);
R2 = R2(2:end-1);
dR = repmat([-1; 0; 1], length(R), 1);
dR = dR(2:end-1);
R1 = R2 + dR;

## All combinations of transitions in v and R
nv = numel(v2);
nR = numel(R2);
v2 = repelem(v2, nR);
v1 = repelem(v1, nR);
R2 = repmat(R2, nv, 1);
R1 = repmat(R1, nv, 1);
dR = repmat(dR, nv, 1);

# Lookup corresponding pre-computed energies
Ev2 = B.Ev(v2+1);
Ev1 = A.Ev(v1+1);
Er2 = B.Er(sub2ind(size(B.Er), v2+1, R2+1));
Er1 = B.Er(sub2ind(size(B.Er), v1+1, R1+1));

# Energy of transition
E = Ev2 + Er2 - (Ev1 + Er1);

# Franck-Condon factors
franckcondon;
fc = FC(sub2ind(size(FC), v2+1, v1+1));

# Hoenl-London factors
hl = zeros(size(dR));
hl(dR==-1) = (R2(dR==-1) + 2) ./ 2;   # P branch
hl(dR==0)  = R2(dR==0)  + 0.5;        # Q branch
hl(dR==1)  = (R2(dR==1)  - 1) ./ 2;   # R branch

# Intensity of the transition
I = fc .* hl .* exp(-ec*Ev2 ./ (k*Tv)) .* exp(-ec*Er2 ./ (k*Tr));

wl = h*c./E;    # Wavelength [m-1]
valid = (!isna(I) & I > 0 & wl > 0);

fwhm = 1e-3(ones(size(I)));
b = fwhm.^2 ./ (4*log(2));
a = sqrt(pi) .* b ./ I;

range = max(wl(valid)) - min(wl(valid));
x = linspace(min(wl(valid))-range/10, max(wl(valid))+range/10, 10000);
yy = arrayfun(@(p,a,b) (1/a)*exp(-((x-p)./b).^2),
	wl(valid), a(valid), b(valid), "UniformOutput", false);
y = sum(cell2mat(yy));
