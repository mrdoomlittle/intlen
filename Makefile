DESTDIR=/usr/local
all:
	g++ -c -Wall -std=c++11 -o lib/intlen.o src/intlen.cpp
	cp src/intlen.hpp inc
	g++ -Wall -std=c++11 -o bin/intlen intlen.cpp lib/intlen.o
clean:
	rm -f lib/*.o
	rm -f bin/*
	rm -f src/*.o
	rm -f inc/*.hpp
install:
	cp bin/intlen /usr/local/bin
remove:
	rm -f /usr/local/bin/intlen
