copy:
	rm -f -R /usr/hla/hlasrc/*
	rm -f -R /usr/hla/hlalibsrc/*
	rm -f -R /usr/hla/include/*
	cp -R /volumes/data/mac/hlalibsrc/* /usr/hla/hlalibsrc
	cp -R /volumes/data/mac/hlalibsrc/trunk/hlainc/* /usr/hla/include
	cp -R /volumes/data/mac/hlasrc/* /usr/hla/hlasrc/trunk

makeHLA:
	rm -f -R /usr/hla/hlalibsrc/*
	rm -f -R /usr/hla/include/*
	cp -R hlalibsrc/* /usr/hla/hlalibsrc
	cp -R include/* /usr/hla/include
	cd hlasrc; make -f makefile.mac
	cd /usr/hla/hlalibsrc; hla delete
	cd /usr/hla/hlalibsrc/mkMake; make -f makefile.unix; mkMake ; make clean
	cd /usr/hla/hlalibsrc; make; make clean
	tar cvf mac.tar /usr/hla/*
	
	
	
	
	








	 
