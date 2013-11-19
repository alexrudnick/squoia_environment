squoia environment
==================

Relatively easy build scripts for [SQUOIA](https://code.google.com/p/squoia/).

Automating the process at https://code.google.com/p/squoia/wiki/Installation


Things you need to do
=====================

Maybe?

    ln -s /usr/bin/doxygen /usr/local/bin/doxygen

    # you may need swig installed
    sudo apt-get install swig

    sudo apt-get install libxml2-dev
    sudo apt-get install xsltproc

    # install these perl modules too.
    sudo cpan XML::LibXML Storable File::Spec::Functions List::MoreUtils AI::NaiveBayes1

    (or just):
    sudo make perlmodules

Definitely:

    make
