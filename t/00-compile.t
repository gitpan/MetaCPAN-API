use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.023

use Test::More  tests => 11 + ($ENV{AUTHOR_TESTING} ? 1 : 0);



my @module_files = (
    'MetaCPAN/API.pm',
    'MetaCPAN/API/Author.pm',
    'MetaCPAN/API/Autocomplete.pm',
    'MetaCPAN/API/Distribution.pm',
    'MetaCPAN/API/Favorite.pm',
    'MetaCPAN/API/File.pm',
    'MetaCPAN/API/Module.pm',
    'MetaCPAN/API/POD.pm',
    'MetaCPAN/API/Rating.pm',
    'MetaCPAN/API/Release.pm',
    'MetaCPAN/API/Source.pm'
);



# no fake home requested

use IPC::Open3;
use IO::Handle;

my @warnings;
for my $lib (@module_files)
{
    # see L<perlfaq8/How can I capture STDERR from an external command?>
    my $stdin = '';     # converted to a gensym by open3
    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, qq{$^X -Mblib -e"require q[$lib]"});
    waitpid($pid, 0);
    is($? >> 8, 0, "$lib loaded ok");

    if (my @_warnings = <$stderr>)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}



is(scalar(@warnings), 0, 'no warnings found') if $ENV{AUTHOR_TESTING};


