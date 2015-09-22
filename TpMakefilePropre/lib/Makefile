LIBMAJOR := 1
LIBMINOR := 0
LIBPATCH := 0


NAME ?= arithmetique
LINKERNAME ?= $(NAME)_library

LIBSTATIC := lib$(LINKERNAME).a
LINKERFILENAME := lib$(LINKERNAME).so
SONAME := $(LINKERFILENAME).$(LIBMAJOR)
REALNAME := $(SONAME).$(LIBMINOR).$(LIBPATCH)

CC ?= gcc

override CFLAGS += -Wall
override LDFLAGS += -L.

override libCFLAGS += -fPIC -Wall -shared

libOBJS = addition.o soustraction.o multiplication.o division.o




$(libOBJS) $(OBJS): ../include/functions.h

libs: $(LIBSTATIC) $(LINKERFILENAME) $(SONAME) $(REALNAME)

$(libOBJS): CFLAGS=$(libCFLAGS)


$(LINKERFILENAME) $(SONAME): $(REALNAME)


$(REALNAME): $(libOBJS)
	mkdir ../bin
	$(CC) $(libCFLAGS) -Wl,-soname,$(SONAME) -o ../bin/$@ $^
	ln -sf ../bin/$@ $(SONAME)
	ln -sf ../bin/$@ $(LINKERFILENAME)


$(LIBSTATIC): $(LIBSTATIC)($(libOBJS))


$(NAME).shared: $(OBJS) -l$(LINKERNAME) $(LINKERFILENAME) $(SONAME) $(REALNAME)
	$(CC) -o $@ $^

$(NAME).static: $(OBJS) $(LIBSTATIC)
	$(CC) -o $@ $^


run: $(NAME).shared
	LD_LIBRARY_PATH=../bin:$LD_LIBRARY_PATH ./$(NAME).shared
runShared: run
runStatic: $(NAME).static
	../bin/$(NAME).static
