use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'InfluxDB2::FLUX',
    AUTHOR           => q{Craig Hobbs <chobbs10@me.com>},
    VERSION_FROM     => 'lib/InfluxDB2/FLUX.pm',
    ABSTRACT_FROM    => 'lib/InfluxDB2/FLUX.pm',
    LICENSE          => 'perl_5',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        #'ABC'              => 1.6,
        #'Foo::Bar::Module' => 5.0401,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'InfluxDB2-FLUX-*' },
);
