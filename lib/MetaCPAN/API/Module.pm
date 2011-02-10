use strict;
use warnings;
package MetaCPAN::API::Module;
BEGIN {
  $MetaCPAN::API::Module::VERSION = '0.01_03';
}
# ABSTRACT: Module and dist information for MetaCPAN::API

use Any::Moose 'Role';

requires '_http_req';

has module_prefix => (
    is      => 'ro',
    isa     => 'Str',
    default => 'module',
);

# http://api.metacpan.org/module/_search?q=dist:moose
sub search_dist {
    my $self     = shift;
    my $dist     = shift;
    my %req_opts = @_;
    my $base     = $self->base_url;
    my $prefix   = $self->module_prefix;
    my $url      = "$base/$prefix/_search?q=distname:$dist";
    my @hits     = $self->_get_hits(
        $self->_http_req( $url, \%req_opts )
    );

    return @hits;
}

# http://api.metacpan.org/module/Moose
sub search_module {
    my $self     = shift;
    my $module   = shift;
    my %req_opts = @_ || ();
    my $base     = $self->base_url;
    my $prefix   = $self->module_prefix;
    my $url      = "$base/$prefix/$module";
    my @hits     = $self->_get_hits(
        $self->_http_req( $url, \%req_opts )
    );

    return @hits;
}

1;

__END__
=pod

=head1 NAME

MetaCPAN::API::Module - Module and dist information for MetaCPAN::API

=head1 VERSION

version 0.01_03

=head1 AUTHOR

  Sawyer X <xsawyerx@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Sawyer X.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

