use strict;
use warnings;
package MetaCPAN::API::Author;
BEGIN {
  $MetaCPAN::API::Author::VERSION = '0.01_02';
}
# ABSTRACT: Author information for MetaCPAN::API

use Any::Moose 'Role';
use URI::Escape;

requires '_http_req';

has author_prefix => (
    is      => 'ro',
    isa     => 'Str',
    default => 'author',
);

sub search_author {
    my $self = shift;
    my $term = shift;
    my @hits = ();

    # clean leading/trailing spaces
    $term =~ s/^\s+//;
    $term =~ s/\s+$//;

    # if there are no spaces, it might be a PAUSE ID
    if ( $term !~ /\s/ ) {
        push @hits, $self->_get_hits( $self->search_author_pauseid($term) );
    }

    # search by name
    push @hits, $self->_get_hits( $self->search_author_name($term) );

    # search by wildcard
    push @hits, $self->_get_hits( $self->search_author_wildcard($term) );

    # remove uniques
    my %seen   = ();
    my @unique = grep { ! $seen{ $_->{'_id'} }++ } @hits;

    return @unique;
}

# http://api.metacpan.org/author/DROLSKY
sub search_author_pauseid {
    my $self    = shift;
    my $pauseid = shift;
    my $base    = $self->base_url;
    my $prefix  = $self->author_prefix;
    my $url     = "$base/$prefix/$pauseid";
    my $result  = $self->_http_req($url);

    return $result;
}

# http://api.metacpan.org/author/_search?q=name:Dave
# http://api.metacpan.org/author/_search?q=name:%22dave%20rolsky%22
sub search_author_name {
    my $self   = shift;
    my $name   = shift;
    my $base   = $self->base_url;
    my $prefix = $self->author_prefix;

    # escape letters, specifying the regex because by default
    # it will not escape quotations, which it should
    $name = uri_escape( $name, q{^A-Za-z0-9\-\._~} );

    my $url    = "$base/$prefix/_search?q=name:$name";
    my $result = $self->_http_req($url);

    return $result;
}

# http://api.metacpan.org/author/_search?q=author:D*
sub search_author_wildcard {
    my $self   = shift;
    my $term   = shift; # you decide on the wildcard when you call the method
    my $base   = $self->base_url;
    my $prefix = $self->author_prefix;
    my $url    = "$base/$prefix/_search?q=author:$term";
    my $result = $self->_http_req($url);

    return $result;
}

1;

__END__
=pod

=head1 NAME

MetaCPAN::API::Author - Author information for MetaCPAN::API

=head1 VERSION

version 0.01_02

=head1 AUTHOR

  Sawyer X <xsawyerx@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Sawyer X.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

