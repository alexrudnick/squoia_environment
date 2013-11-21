squoia environment
==================

Relatively easy build scripts for [SQUOIA](https://code.google.com/p/squoia/).

Automating the process at https://code.google.com/p/squoia/wiki/Installation


Things you need to do
=====================
Definitely:

    make

But first:

  * get the Ancora Spanish lexicon from here: http://clic.ub.edu/corpus/en/ancora-descarregues
    * you'll have to register for an account to download the lexicon. This requires waiting for human intervention on their part, because "good job, champ."


Maybe?

    ln -s /usr/bin/doxygen /usr/local/bin/doxygen

    # you may need swig installed
    sudo apt-get install swig

    sudo apt-get install libxml2-dev
    sudo apt-get install xsltproc
    sudo apt-get install libpcre++-dev

    # install these perl modules too.
    sudo cpan XML::LibXML Storable File::Spec::Functions List::MoreUtils AI::NaiveBayes1

    (or just):
    sudo make perlmodules

