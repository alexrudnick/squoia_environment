all: freelinginstall squoia-read-only squoia-analyzer

SQUOIAENV=$(CURDIR)

squoia-read-only:
	svn checkout http://squoia.googlecode.com/svn/trunk/ squoia-read-only

freeling-3.1:
	wget http://devel.cpl.upc.edu/freeling/downloads/32 -O freeling-3.1.tar.gz
	tar xf freeling-3.1.tar.gz

freelinginstall: freeling-3.1
	mkdir -p freelinginstall
	cd freeling-3.1 ; \
	./configure --prefix=$(SQUOIAENV)/freelinginstall ; \
	make ; \
	echo SQUOIAENV $(SQUOIAENV); \
	make install
