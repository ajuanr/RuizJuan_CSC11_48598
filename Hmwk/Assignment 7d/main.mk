# Makefile
all: arrayFloat

main: arrayFloat.o
      gcc -o $@ $+

main.o: arrayFloat.s
      as -mfpu=vfpv2 -o $@ $<

clean:
      rm -vf *.o
