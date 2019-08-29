main.exe : independant_io.o
	mpif90 -O2 independant_io.o -o main.exe


independant_io.o : independant_io.f90
	mpif90 -O2 -c independant_io.f90 -o independant_io.o

#main.exe : independant_io.o
#	mpif90 -O2 independant_io.o -o main.exe

run : main.exe	
	mpirun -np 4 ./main.exe

clean :
	rm -f *.o *.bin *.exe
