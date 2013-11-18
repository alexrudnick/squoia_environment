all: freelinginstall squoia-read-only squoia_analyzer desrinstall desr_models \
     lttoolbox

SQUOIAENV=$(CURDIR)

FREELING_SRC=freeling-3.1

FLM=squoia-read-only/FreeLingModules
FLINCLUDE=freelinginstall/include/
DESRHOME=desr-1.4.2/
DESRMODULES=squoia-read-only/desrModules/

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

squoia_analyzer:
	cp $(FREELING_SRC)/src/main/sample_analyzer/*.h freelinginstall/include
	cp squoia-read-only/FreeLingModules/config_squoia/config.h freelinginstall/include/
	g++ -c -o $(FLM)/output_squoia.o $(FLM)/output_squoia.cc -I$(FLINCLUDE)
	g++ -c -o $(FLM)/squoia_analyzer.o $(FLM)/squoia_analyzer.cc -I$(FLINCLUDE)
	bash $(FREELING_SRC)/libtool --tag=CXX --mode=link g++ -O3 -Wall \
	$(FLM)/squoia_analyzer.o $(FLM)/output_squoia.o \
	$(FREELING_SRC)/src/main/sample_analyzer/analyzer.o  \
	-Lfreelinginstall/lib -lfreeling -lboost_program_options-mt -lboost_system -lboost_filesystem-mt -lpthread \
	-o freelinginstall/bin/squoia_analyzer
	python build_config.py > squoia-read-only/FreeLingModules/squoia.cfg

desr-1.4.2.tgz:
	wget http://downloads.sourceforge.net/project/desr/Release/desr-1.4.2.tgz

desr-1.4.2: desr-1.4.2.tgz
	tar xf desr-1.4.2.tgz

desrinstall: desr-1.4.2
	mkdir -p desrinstall
	## PATCH IT UP: these files need unistd.h on Ubuntu.
	sed -i "1s/^/#include <unistd.h> \n/"  desr-1.4.2/src/SvmParser.cpp
	sed -i "1s/^/#include <unistd.h> \n/"  desr-1.4.2/src/MultiSvmParser.cpp
	cd desr-1.4.2 ; ./configure --prefix=$(SQUOIAENV)/desrinstall;
	# ham-fistedly remove mention of desr.py because wtf.
	sed -i "s/\bdesr.py\b//"  desr-1.4.2/src/Makefile
	cd desr-1.4.2/src/blas; make

	cd desr-1.4.2; make
	mkdir -p desrinstall/bin
	cp desr-1.4.2/src/desr desr-1.4.2/src/*.so desrinstall/bin

desr_server_client:
	g++ $(DESRMODULES)/desr_client.cc -o $(DESRMODULES)/desr_client -I$(FLINCLUDE)
	g++ $(DESRMODULES)/desr_server.cc -o $(DESRMODULES)/desr_server -std=gnu++0x -I/usr/include/python2.7/ -I$(FLINCLUDE) -I$(DESRHOME)/src -I$(DESRHOME) -I$(DESRHOME)/ixe/ -I$(DESRHOME)/classifier/ $(DESRHOME)/src/libdesr.so  $(DESRHOME)/ixe/libixe.a -lpthread

desr_models:
	mkdir -p desrinstall/models
	wget "https://sites.google.com/site/desrparser/models/spanish.conf?attredirects=0&d=1" -O desrinstall/models/spanish.conf
	wget http://medialab.di.unipi.it/Project/QA/Parser/models/spanish_es4.MLP -O desrinstall/models/spanish_es4.MLP
	wget http://medialab.di.unipi.it/Project/QA/Parser/models/spanish.MLP -O desrinstall/models/spanish.MLP

lttoolbox:
	svn co https://svn.code.sf.net/p/apertium/svn/trunk/lttoolbox
	## TODO(alexr): compile lttoolbox

perlmodules:
	## can't currently install File::Basename -- why?
	cpan XML::LibXML Storable File::Basename File::Spec::Functions \
             List::MoreUtils AI::NaiveBayes1

