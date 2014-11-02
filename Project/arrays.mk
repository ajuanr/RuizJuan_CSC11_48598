# Makefile
all: arrays

main: arrays.o
      gcc -o $@ $+

main.o: arrays.s
      as -o $@ $<

clean:
      rm -vf *.o
