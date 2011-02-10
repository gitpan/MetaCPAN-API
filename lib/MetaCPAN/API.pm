use strict;
use warnings;
package MetaCPAN::API;
BEGIN {
  $MetaCPAN::API::VERSION = '0.01_03';
}
# ABSTRACT: A comprehensive, DWIM-featured API to MetaCPAN

use Any::Moose;
use JSON;
use Carp;
use Try::Tiny;
use HTTP::Tiny;

with qw/
    MetaCPAN::API::Author
    MetaCPAN::API::CPANRatings
    MetaCPAN::API::Module
    MetaCPAN::API::POD
/;

has base_url => (
    is      => 'ro',
    isa     => 'Str',
    default => 'http://api.metacpan.org',
);

has ua => (
    is         => 'ro',
    isa        => 'HTTP::Tiny',
    lazy_build => 1,
);

sub _build_ua {
    return HTTP::Tiny->new;
}

sub _get_hits {
    my $self     = shift;
    my $response = shift;
    my @hits     = ();

    try {
        # a single search might return partial JSON data, but no hits,
        # search dist for "Moose", or author for "Dave", it will come up
        # in that case, we need to check for a _source key

        my $content = decode_json $response->{'content'};

        if ( exists $content->{'hits'}{'hits'} ) {
            @hits = @{ $content->{'hits'}{'hits'} };
        } elsif ( exists $content->{'_source'} ) {
            @hits = $content;
        }
    } catch {
        croak 'There was an error decoding response from MetaCPAN.';
    };

    return @hits;
}

sub _http_req {
    my $self               = shift;
    my ( $url, $req_opts ) = @_;

    my $res = $self->ua->request( 'GET', $url, $req_opts );

    return $res;
}

1;

__END__
=pod

=head1 NAME

MetaCPAN::API - A comprehensive, DWIM-featured API to MetaCPAN

=head1 VERSION

version 0.01_03

=head1 AUTHOR

  Sawyer X <xsawyerx@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Sawyer X.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

