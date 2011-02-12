use strict;
use warnings;
package MetaCPAN::API::POD;
BEGIN {
  $MetaCPAN::API::POD::VERSION = '0.02';
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



=pod

=head1 NAME

MetaCPAN::API::POD - POD information for MetaCPAN::API

=head1 VERSION

version 0.02

=head1 DESCRIPTION

This role provides MetaCPAN::API with several methods to get the CPAN Ratings
information.

=head1 ATTRIBUTES

=head2 pod_prefix

This attribute helps set the path to the POD requests in the REST API.
You will most likely never have to touch this as long as you have an updated
version of MetaCPAN::API.

Default: I<pod>.

This attribute is read-only (immutable), meaning that once it's set on
initialize (via C<new()>), you cannot change it. If you need to, create a
new instance of MetaCPAN::API. Why is it immutable? Because it's better.

=head1 METHODS

=head2 search_pod

    my $result = $mcpan->search_pod('MetaCPAN::API');

Search for the POD of a specific module.

=head1 AUTHOR

  Sawyer X <xsawyerx@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Sawyer X.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

