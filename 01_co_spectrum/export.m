main;

if (!isfolder("results"))
	mkdir("results");
end

f = fopen("results/co_spectrum.csv", "w");
fwrite(f, "E[eV],I\n");
dlmwrite(f, [x./ec y]);
fclose(f);
