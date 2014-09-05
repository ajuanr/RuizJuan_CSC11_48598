PROGRAMS = prob6b

# If we've supplied a goal on the command line
# then add this to the list of programs we
# already know about
ifneq ($(MAKECMDGOALS),)
PROGRAMS = $(MAKECMDGOALS)
endif

# The default rule if none is specified on
# the command line
all: $(PROGRAMS)

# make knows how to compile .s files, so all
# we need to do is link them
$(PROGRAMS): % : %.o
	ld -o $@ $<

clean:
	rm -f *.o $(PROGRAMS)
