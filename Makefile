SHELL :=/bin/bash
DEF_INSTALL=/usr/local
INSTALL_DIR=$(DEF_INSTALL)

NO_BINARY=false
INC_DIR_NAME=include
MDLINT_INC=$(DEF_INSTALL)/$(INC_DIR_NAME)

INC=-Iinc -I$(MDLINT_INC)
LIB=-Llib
LL=-lmdl-intlen

ARC=ARC32
CFG=
RUST_LIBS=false

all: build
ARC64:
	make build ARC=ARC64 CFG=--cfg RUST_LIBS=$(RUST_LIBS) MDLINT_INC=$(MDLINT_INC)
ARC32:
	make build ARC=ARC32 CFG=--cfg RUST_LIBS=$(RUST_LIBS) MDLINT_INC=$(MDLINT_INC)

build: src/intlen.o libmdl-intlen.a
	cp src/intlen.hpp inc/mdl
	cp libmdl-intlen.a lib

	if [ $(RUST_LIBS) = true ]; then\
		make rust-libs R_ARC=$(R_ARC) CFG=$(CFG);\
		cp libmdl-intlen.rlib rlib;\
		rustc -Lrlib -o bin/intlen.rust intlen.rs -lmdl-intlen;\
	fi;

	if [ $(NO_BINARY) = false ]; then\
		g++ -Wall -std=c++11 $(INC) $(LIB) -D__$(ARC) -o bin/intlen intlen.cpp $(LL);\
	fi;
rust-libs: src/libmdl-intlen.rlib

libmdl-intlen.a: src/intlen.o
	ar rcs libmdl-intlen.a src/intlen.o

src/intlen.o: src/intlen.cpp
	g++ -c -Wall -fPIC -std=c++11 $(INC) -D__$(ARC) -o src/intlen.o src/intlen.cpp

src/libmdl-intlen.rlib: src/intlen.rs
	rustc -Llib $(CFG) $(R_ARC) --crate-type=lib -o libmdl-intlen.rlib src/intlen.rs

clean:
	rm -f bin/*
	rm -f lib/*.a
	rm -f *.a
	rm -f *.rlib
	rm -f rlib/*.rlib
	rm -f inc/mdl/*.hpp
	rm -f src/*.o
install:
	mkdir -p $(INSTALL_DIR)/bin
	mkdir -p $(INSTALL_DIR)/lib
	mkdir -p $(INSTALL_DIR)/rlib
	mkdir -p $(INSTALL_DIR)/$(INC_NAME)

	cp bin/intlen $(INSTALL_DIR)/bin/intlen
	cp lib/libmdl-intlen.a $(INSTALL_DIR)/lib
	if [ -f rlib/libmdl-intlen.rlib ]; then\
		cp rlib/libmdl-intlen.rlib $(INSTALL_DIR)/rlib;\
	fi;

	mkdir -p $(INSTALL_DIR)/$(INC_NAME)/mdl
	cp inc/intlen.hpp $(INSTALL_DIR)/$(INC_NAME)/mdl
uninstall:
	rm -f $(INSTALL_DIR)/bin/intlen
	rm -f $(INSTALL_DIR)/lib/libmdl-intlen.a
	rm -f $(INSTALL_DIR)/rlib/libmdl-intlen.rlib
	rm -rf $(INSTALL_DIR)/$(INC_NAME)/mdl
