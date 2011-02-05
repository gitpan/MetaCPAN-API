use strict;
use warnings;
package MetaCPAN::API::CPANRatings;
BEGIN {
  $MetaCPAN::API::CPANRatings::VERSION = '0.01_01';
}
# ABSTRACT: CPAN Ratings information for MetaCPAN::API

use Any::Moose 'Role';

requires 'render_result';

has cpanratings_prefix => (
    is      => 'ro',
    isa     => 'Str',
    default => 'cpanratings',
);

# http://api.metacpan.org/cpanratings/Moose
sub search_cpanratings_exact {
    my $self    = shift;
    my $dist    = shift;
    my $base    = $self->base_url;
    my $prefix  = $self->cpanratings_prefix;
    my $url     = "$base/$prefix/$dist";
    my $result  = $self->ua->get($url);

    return $result;
}

# http://api.metacpan.org/cpanratings/_search?q=dist:Moose
sub search_cpanratings_like {
    my $self   = shift;
    my $dist   = shift;
    my $base   = $self->base_url;
    my $prefix = $self->cpanratings_prefix;
    my $url    = "$base/$prefix/_search?q=dist:$dist";
    my $result = $self->ua->get($url);

    return $result;
}

1;

__END__
=pod

=head1 NAME

MetaCPAN::API::CPANRatings - CPAN Ratings information for MetaCPAN::API

=head1 VERSION

version 0.01_01

=head1 AUTHOR

  Sawyer X <xsawyerx@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Sawyer X.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

