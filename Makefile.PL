use ExtUtils::MakeMaker;

WriteMakefile(
    NAME	 => "WWW::Search::Google",
    VERSION_FROM => 'Google.pm',
    PREREQ_PM    =>  {
	      SOAP::Lite           => 0.01,
	      Test::Simple         => 0.01,
	     },
    AUTHOR       => 'Leon Brocard <acme@astray.com>',
    ABSTRACT     => 'WWW::Search::Google searches Google via SOAP'
);


