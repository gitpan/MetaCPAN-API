use strict;
use warnings;
package MetaCPAN::API::POD;
BEGIN {
  $MetaCPAN::API::POD::VERSION = '0.01_02';
}
# ABSTRACT: POD information for MetaCPAN::API

use Any::Moose 'Role';

requires '_http_req';

has pod_prefix => (
    is      => 'ro',
    isa     => 'Str',
    default => 'pod',
);

# http://api.metacpan.org/pod/AAA::Demo
sub search_pod {
    my $self    = shift;
    my $dist    = shift;
    my $base    = $self->base_url;
    my $prefix  = $self->pod_prefix;
    my $url     = "$base/$prefix/$dist";
    my $result  = $self->_http_req($url);

    return $result;
}

1;

__END__
=pod

=head1 NAME

MetaCPAN::API::POD - POD information for MetaCPAN::API

=head1 VERSION

version 0.01_02

=head1 AUTHOR

  Sawyer X <xsawyerx@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Sawyer X.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

