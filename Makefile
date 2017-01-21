SHELL :=/bin/bash
DESTDIR=/usr/local
ARC=
R_ARC=
CFG=
RUST_LIBS=false

all: build

ARC64:
	make build ARC=-DARC64 R_ARC=ARC64 CFG=--cfg
ARC32:
	make build ARC=-DARC32 R_ARC=ARC32 CFG=--cfg
build: src/intlen.o src/libintlen.a
	cp src/intlen.hpp inc
	cp src/libintlen.a lib
	
	if [ $(RUST_LIBS) = true ]; then\
		make rust-libs R_ARC=$(R_ARC) CFG=$(CFG);\
		cp src/libintlen.rlib rlib;\
		rustc -Lrlib -o bin/intlen.rust intlen.rs -lintlen;\
	fi;
		
	g++ -Wall -std=c++11 $(ARC) -Iinc -Llib -o bin/intlen intlen.cpp -lintlen

rust-libs: src/libintlen.rlib

src/libintlen.a: src/intlen.o
	ar rcs src/libintlen.a src/intlen.o

src/intlen.o: src/intlen.cpp
	g++ -c -Wall -fPIC -std=c++11 $(ARC) -o src/intlen.o src/intlen.cpp

src/libintlen.rlib: src/intlen.rs
	rustc -Llib $(CFG) $(R_ARC) --crate-type=lib -o src/libintlen.rlib src/intlen.rs

clean:
	rm -f bin/*
	rm -f lib/*.a
	rm -f rlib/*.rlib
	rm -f inc/*.hpp
	rm -f src/*.o
	rm -f src/*.a
	rm -f src/*.rlib
install:
	mkdir -p $(DESTDIR)/bin
	mkdir -p $(DESTDIR)/lib
	mkdir -p $(DESTDIR)/rlib
	mkdir -p $(DESTDIR)/include
	cp bin/intlen $(DESTDIR)/bin/intlen
	cp lib/libintlen.a $(DESTDIR)/lib/libintlen.a
	if [ -f rlib/libintlen.rlib ]; then\
		cp rlib/libintlen.rlib $(DESTDIR)/rlib/libintlen.rlib;\
	fi;
	cp inc/intlen.hpp $(DESTDIR)/include/intlen.hpp
uninstall:
	rm -f $(DESTDIR)/bin/intlen
	rm -f $(DESTDIR)/lib/libintlen.a
	rm -f $(DESTDIR)/rlib/libintlen.rlib
	rm -f $(DESTDIR)/include/intlen.hpp
