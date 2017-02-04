#
#SUFFIX= -c 
SUFFIX= -c -O3
LIBS = -static 
#SUFFIX= -c -fpe2
FSALGEM= reac.f poten.f ffopt.f shanno.f version.f vibra.f blas.f
OBJECT= reac.o poten.o ffopt.o shanno.o version.o vibra.o blas.o
UPDATE= update
INCLUD= cbka.blk cbkm.blk opt.blk 
#
        reac:$(UPDATE) $(OBJECT) $(INCLUD) 
	gfortran -o $@ $(OBJECT) $(LIBS)
	date >> compile.log
clean: 
	rm -rf reac reac.o poten.o ffopt.o shanno.o version.o vibra.o blas.o

update:
	makedate
reac.o: reac.f $(INCLUD) 
	gfortran $(SUFFIX) reac.f
poten.o: poten.f $(INCLUD) 
	gfortran $(SUFFIX) poten.f
ffopt.o: ffopt.f $(INCLUD) 
	gfortran $(SUFFIX) ffopt.f
shanno.o: shanno.f $(INCLUD) 
	gfortran $(SUFFIX) shanno.f
version.o: version.f $(INCLUD) 
	gfortran $(SUFFIX) version.f
vibra.o: vibra.f $(INCLUD)
	gfortran $(SUFFIX) vibra.f
blas.o: blas.f $(INCLUD)
	gfortran $(SUFFIX) blas.f
