## Copyright 2022 Lukas Vrana, Jan Slany, Radek Hornak
##
## Permission is hereby granted, free of charge, to any person obtaining a copy
## of this software and associated documentation files (the "Software"), to deal
## in the Software without restriction, including without limitation the rights
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
## copies of the Software, and to permit persons to whom the Software is
## furnished to do so, subject to the following conditions:
##
## The above copyright notice and this permission notice shall be included in
## all copies or substantial portions of the Software.
##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
## SOFTWARE.

## Model of the emission spectrum of carbon monoxide (CO) molecule
## undergoing a transition between the following electronic states:
##
##     B1Sigma+ -> A1Pi
##
## The resulting x, y values are the energies in joules
## and spectral intensity in arbitrary units.

# Physical constants
global c = 299792458;     # Speed of light in vacuum [m/s]
global h = 6.626070e-34;  # Planck constant [J*s]
global k = 1.380649e-23;  # Boltzmann constant [J/K]
global ec = 1.60218e-19;  # Elementary charge [C]
global u = 1.661e-27;     # Atomic mass constant [kg]

M = 28;
Tv = 2000;                # Vibrational temperature [K]
Tr = 300;                 # Rotational temperature [K]

# The upper state: B1Sigma+
B.ome = 2112.7*1e2;       # [m-1]
B.omexe = 15.2*1e2;       # [m-1]
B.B = 1.961*1e2;          # [m-1]
B.ae = 0.026*1e2;         # [m-1]
B.De = 7.1e-4;            # [m-1]
B.Te = 86945.2e2;         # [m-1]

# The lower state: A1Pi
A.ome = 1518.2*1e2;       # [m-1]
A.omexe = 19.4*1e2;       # [m-1]
A.B = 1.611*1e2;          # [m-1]
A.ae = 0.023*1e2;         # [m-1]
A.De = 7.33e-4;           # [m-1]
A.Te = 65075.7e2;         # [m-1]

v = (0:10)';              # Vibrational numbers
R = 0:30;                 # Rotational numbers

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
Er1 = A.Er(sub2ind(size(A.Er), v1+1, R1+1));

Ee2 = h*c*B.Te;
Ee1 = h*c*A.Te;

# Energy of transition
E = Ee2 + Ev2 + Er2 - (Ee1 + Ev1 + Er1);

# Franck-Condon factors
franckcondon;
fc = FC(sub2ind(size(FC), v2+1, v1+1));

# Hoenl-London factors
hl = zeros(size(dR));
hl(dR==-1) = (R2(dR==-1) + 2) ./ 2;   # P branch
hl(dR==0)  = R2(dR==0)  + 0.5;        # Q branch
hl(dR==1)  = (R2(dR==1)  - 1) ./ 2;   # R branch

# Intensity of the transition
I = fc .* hl .* exp(-Ev2 ./ (k*Tv)) .* exp(-Er2 ./ (k*Tr));

wl = h*c./E;    # Wavelength [m-1]
valid = (!isna(I) & I > 0 & wl > 0);

## Doppler broadening
Tkin = Tr;
dwl_dop = sqrt(2*k*Tkin*log(2) / (M*u)) * 2 * wl ./ c;
dE_dop = h^2*c^2./(dwl_dop .* E.^2);

fwhm = 1e-11(ones(size(I)));
b = fwhm.^2 ./ (4*log(2));
a = sqrt(pi) .* b ./ I;

range = max(E(valid)) - min(E(valid));
x = linspace(min(E(valid))-range/10, max(E(valid))+range/10, 100000)';
y = zeros(size(x));
aa = a(valid);
bb = b(valid);
EE = E(valid);
for i = 1:sum(valid)
	y += (1/aa(i)) * exp(-((x-EE(i)) ./ bb(i)).^2);
endfor
