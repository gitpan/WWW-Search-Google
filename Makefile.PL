use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME	 => "WWW::Search::Google",
  VERSION_FROM => 'Google.pm',
  PREREQ_PM    =>  {
   'Net::Google' => "0.52",
   'WWW::Search' => "2.35",
   'Test::More' => "0.01",
  },
  AUTHOR       => 'Leon Brocard <acme@astray.com>',
  ABSTRACT     => 'WWW::Search::Google searches Google via SOAP'
);


sub MY::libscan {
  my $path = $_[1];
  return '' if $path =~ /\B\.svn\b/;
  return $path;
}
