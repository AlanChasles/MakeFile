CC?=gcc
AR?=ar
SYMLINK?=ln -sf

CFLAGS?=-Wall -fPIC -c


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
	$(CC) -o $(PROG).static main.o -L. -l:$(LIBSTATIC)
	$(CC) -o $(PROG) main.o -L. -l$(LINKERNAME)
	LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH ./$(PROG)

main.o: main.c
	$(CC) $(CFLAGS) $^

addition.o: addition.c
	$(CC) $(CFLAGS) $^

soustraction.o: soustraction.c
	$(CC) $(CFLAGS) $^

multiplication.o: multiplication.c
	$(CC) $(CFLAGS) $^ 

division.o: division.c
	$(CC) $(CFLAGS) $^

$(LIBSTATIC): $(LOBJ)
	$(AR) rcs $(LIBSTATIC) $^

$(REALNAME): $(LOBJ)
	$(CC) -shared -fPIC -Wl,-soname,$(SONAME) -o $(REALNAME) 		$^ -lc
	$(SYMLINK) $(REALNAME) $(SONAME)
	$(SYMLINK) $(REALNAME) $(LINKERFILENAME)


libs:$(LIBSTATIC) $(REALNAME)

clean:
	rm -f *.o *$(PROG)*
	
