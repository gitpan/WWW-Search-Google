use ExtUtils::MakeMaker;
#Auto generated by makeMOD.pl by Jim Smyser


WriteMakefile(
    'NAME'	=> 'WWW::Search::Google',
    'VERSION_FROM' => 'Google.pm', # finds $VERSION
    'dist'  => { COMPRESS => 'gzip', SUFFIX => 'gz' },
    'PREREQ_PM' => { 'WWW::Search' => 2},
);
