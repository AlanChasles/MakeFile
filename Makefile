CC=gcc
AR=ar
CFLAGS=-Wall -fPIC -c

PROG=arithmetique
LOBJ=addition.o soustraction.o division.o multiplication.o
#Bibliothèques
LINKERNAME=$(PROG)_library
LINKERFILENAME=lib$(LINKERNAME).so
SONAME=$(LINKERFILENAME)$(LIBMAJOR)
LIBSTATIC=lib$(LINKERNAME).a
REALNAME=$(SONAME)$(LIBMINOR)$(LIBMAJOR)
LIBMINOR=.0
LIBMAJOR=.1
LIBPATCH=.0



$(PROG): $(LIBSTATIC) $(REALNAME) main.o
	$(CC) -o $(PROG).static main.o -L. -l:$(LIBSTATIC)
	$(CC) -o $(PROG) main.o -L. -l$(PROG)_library
	LD_LIBRarY_PATH=.:$LD_LIBRarY_PATH ./$(PROG)

main.o: main.c
	$(CC) $(CFLAGS) main.c

addition.o: addition.c
	$(CC) $(CFLAGS) addition.c

soustraction.o: soustraction.c
	$(CC) $(CFLAGS) soustraction.c

multiplication.o: multiplication.c
	$(CC) $(CFLAGS) multiplication.c

division.o: division.c
	$(CC) $(CFLAGS) division.c

$(LIBSTATIC): $(LOBJ)
	$(AR) rcs $(LIBSTATIC) $(LOBJ)

$(REALNAME): $(LOBJ)
	$(CC) -shared -fPIC -Wl,-soname,$(SONAME) -o $(REALNAME) $(LOBJ) -lc
	ln -sf $(REALNAME) $(SONAME)
	ln -sf $(REALNAME) $(LINKERFILENAME)


$(PROG): $(LIBSTATIC) $(REALNAME) main.o
	$(CC) -o $(PROG).static main.o -L. -l:$(LIBSTATIC)
	$(CC) -o $(PROG) main.o -L. -l$(PROG)_library
	LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH ./$(PROG)

libs:$(LIBSTATIC) $(REALNAME)

clean:
	rm -f *.o *$(PROG)*
	
