CC?=gcc
AR?=ar
SYMLINK?=ln -sf

override CFLAGS+=-Wall -fPIC
override LDFLAGS+=-L.
override LIBCFLAGS+=-shared -fPIC
LDLIBS = -lc

PROG?=arithmetique
LOBJ:=addition.o soustraction.o division.o multiplication.o

#Bibliothèques

LINKERNAME:=$(PROG)_library
LINKERFILENAME:=lib$(LINKERNAME).so
SONAME:=$(LINKERFILENAME)$(LIBMAJOR)
REALNAME=$(SONAME)$(LIBMINOR)$(LIBPATCH)

LIBSTATIC=lib$(LINKERNAME).a

LIBMAJOR:=.1
LIBMINOR:=.0
LIBPATCH:=.0



$(PROG): main.o $(LIBSTATIC) $(REALNAME) 
	$(CC) -o $@.static $< $(LDFLAGS) -l:$(LIBSTATIC)
	$(CC) -o $@ $< $(LDFLAGS) -l$(LINKERNAME)
	LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH ./$@

	
compilObj: $(LOBJ)

$(LIBSTATIC):$(LIBSTATIC)($(LOBJ))

$(LIBSTATIC): $(LOBJ)

$(REALNAME): $(LOBJ)
	$(CC) $(LIBCFLAGS) -Wl,-soname,$(SONAME) -o $@ $^ $(LDLIBS)
	$(SYMLINK) $@ $(SONAME)
	$(SYMLINK) $@ $(LINKERFILENAME)


libs:$(LIBSTATIC) $(REALNAME)

clean:
	rm -f *.o *$(PROG)*
	
