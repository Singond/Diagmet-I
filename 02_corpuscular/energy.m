addpath octave;

ar(1).filename = "data/ar-discharge_Ar+_iedf6Pa.csv";
ar(1).p = 6.0;
ar(2).filename = "data/ar-discharge_Ar+_iedf2.5Pa.csv";
ar(2).p = 2.5;
ar = arrayfun(@(x) load_data(x, "energy"), ar);

arh(1).filename = "data/ar-discharge_ArH+_iedf6Pa.csv";
arh(1).p = 6.0;
arh(2).filename = "data/ar-discharge_ArH+_iedf2.5Pa.csv";
arh(2).p = 2.5;
arh = arrayfun(@(x) load_data(x, "energy"), arh);

nn(1).filename = "data/ar-discharge_N2+_iedf6Pa.csv";
nn(1).p = 6.0;
nn(2).filename = "data/ar-discharge_N2+_iedf2.5Pa.csv";
nn(2).p = 2.5;
nn = arrayfun(@(x) load_data(x, "energy"), nn);
