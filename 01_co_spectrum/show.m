if (!exist("x", "var"))
	main;
endif

xlabel("energy E [eV]");
plot(x./ec, y.*ec);
