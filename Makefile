DESTDIR=/usr/local
ARC=

all: build

ARC64:
	make build ARC=-DARC64
ARC32:
	make build ARC=-DARC32
build: src/intlen.o
	cp src/intlen.hpp inc
	ar rcs lib/libintlen.a src/intlen.o
	g++ -Wall -std=c++11 $(ARC) -Iinc -Llib -o bin/intlen intlen.cpp -lintlen

src/intlen.o: src/intlen.cpp
	g++ -c -Wall -std=c++11 $(ARC) -o src/intlen.o src/intlen.cpp

clean:
	rm -f bin/*
	rm -f lib/*.a
	rm -f inc/*.hpp
	rm -f src/*.o
install:
	mkdir -p $(DESTDIR)/bin
	mkdir -p $(DESTDIR)/lib
	mkdir -p $(DESTDIR)/include
	cp bin/intlen $(DESTDIR)/bin/intlen
	cp lib/libintlen.a $(DESTDIR)/lib/libintlen.a
	cp inc/intlen.hpp $(DESTDIR)/include/intlen.hpp
uninstall:
	rm -f $(DESTDIR)/bin/intlen
	rm -f $(DESTDIR)/lib/libintlen.a
	rm -f $(DESTDIR)/include/intlen.hpp
