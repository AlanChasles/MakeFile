CC?=gcc
AR?=ar
SYMLINK?=ln -sf

CFLAGS?=-Wall -fPIC
LDFLAGS?=-L.

PROG?=arithmetique
LOBJ:=addition.o soustraction.o division.o multiplication.o

#Bibliothèques

LINKERNAME=$(PROG)_library
LINKERFILENAME=lib$(LINKERNAME).so
SONAME=$(LINKERFILENAME)$(LIBMAJOR)
REALNAME=$(SONAME)$(LIBMINOR)$(LIBPATCH)

LIBSTATIC=lib$(LINKERNAME).a

LIBMAJOR=.1
LIBMINOR=.0
LIBPATCH=.0



$(PROG): $(LIBSTATIC) $(REALNAME) main.o
	$(CC) -o $@.static main.o $(LDFLAGS) -l:$(LIBSTATIC)
	$(CC) -o $@ main.o $(LDFLAGS) -l$(LINKERNAME)
	LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH ./$@

	
compilObj: $(LOBJ)


$(LIBSTATIC): $(LOBJ)
	$(AR) rcs $@ $^

$(REALNAME): CFLAGS=-shared -fPIC

$(REALNAME): $(LOBJ)
	$(CC) $(CFLAGS) -Wl,-soname,$(SONAME) -o $@ $^ -lc
	$(SYMLINK) $@ $(SONAME)
	$(SYMLINK) $@ $(LINKERFILENAME)


libs:$(LIBSTATIC) $(REALNAME)

clean:
	rm -f *.o *$(PROG)*
	
