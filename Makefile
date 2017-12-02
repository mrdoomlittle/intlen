SHELL :=/bin/bash
def_install_dir=/usr/local
ifndef install_dir
 install_dir=$(def_install_dir)
endif

no_binary=true
ifndef mdlint_inc_dir
 mdlint_inc_dir=$(dir_include_dir)
endif

inc_flags=-Iinc -I$(mdlint_inc_dir)
lib_flags=-Llib
ld_flags=-lmdl-intlen

ifndef arc
	arc=ARC32
endif

build_rust_lib=false

all: build
arc64:
	make build arc=ARC64 build_rust_lib=$(build_rust_lib) mdlint_inc_dir=$(mdlint_inc_dir)
arc32:
	make build arc=ARC32 build_rust_lib=$(build_rust_lib) mdlint_inc_dir=$(mdlint_inc_dir)

build: src/intlen.o libmdl-intlen.a
	cp src/intlen.hpp inc/mdl
	if [ $(build_rust_lib) = true ]; then\
		make rust-libs arc=$(arc);\
		rustc -Lrlib -o bin/intlen.rust intlen.rs -lmdl-intlen;\
	fi;

	if [ $(no_binary) = false ]; then\
		g++ -Wall -std=c++11 $(inc_flags) $(lib_flags) -D__$(arc) -o bin/intlen intlen.cpp $(ld_flags);\
	fi;

rust-libs: src/libmdl-intlen.rlib
libmdl-intlen.a: src/intlen.o
	ar rcs lib/libmdl-intlen.a src/intlen.o

src/intlen.o: src/intlen.cpp
	g++ -c -Wall -fPIC -std=c++11 $(inc_flags) -D__$(arc) -o src/intlen.o src/intlen.cpp

src/libmdl-intlen.rlib: src/intlen.rs
	rustc -Llib --cfg $(arc) --crate-type=lib -o rlib/libmdl-intlen.rlib src/intlen.rs

clean:
	rm -f bin/*
	rm -f lib/*.a
	rm -f rlib/*.rlib
	rm -f inc/mdl/*.hpp
	rm -f src/*.o
install:
	mkdir -p $(install_dir)/bin
	mkdir -p $(install_dir)/lib
	mkdir -p $(install_dir)/rlib
	mkdir -p $(install_dir)/include

	if [ -f bin/intlen ]; then \
		cp bin/intlen $(install_dir)/bin/intlen; \
	fi;

	cp lib/libmdl-intlen.a $(install_dir)/lib
	if [ -f rlib/libmdl-intlen.rlib ]; then \
		cp rlib/libmdl-intlen.rlib $(install_dir)/rlib;\
	fi;

	mkdir -p $(install_dir)/include/mdl
	cp inc/mdl/intlen.hpp $(install_dir)/include/mdl
uninstall:
	rm -f $(install_dir)/bin/intlen
	rm -f $(install_dir)/lib/libmdl-intlen.a
	rm -f $(install_dir)/rlib/libmdl-intlen.rlib
	rm -rf $(install_dir)/include/mdl
