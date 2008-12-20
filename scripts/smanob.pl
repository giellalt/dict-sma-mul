#/usr/bin/perl -w

use UTF-8;

use strict;
use XML::Twig;

# permit named arguments
use Getopt::Long;

my $output_file;  #e.g. noun-kom-lex.txt
my $pos_name=''; # e.g. N
my $lex_file;      # kom-lex.xml
my $output_dir;
my $help = '';

# Create XML tree for the lexicon
my $twig = new XML::Twig;
$twig->parsefile( "smenob.xml");
my $root = $twig->root;	# Get the root of the twig

	my @entries = $root->children;
	foreach my $e (@entries) {
	
	