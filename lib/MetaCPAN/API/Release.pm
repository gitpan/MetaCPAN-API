use strict;
use warnings;
package MetaCPAN::API::Release;
BEGIN {
  $MetaCPAN::API::Release::VERSION = '0.10';
}
# ABSTRACT: Distribution and releases information for MetaCPAN::API

use Carp;
use Any::Moose 'Role';

# /release/{distribution}
# /release/{author}/{release}
sub release {
    my $self  = shift;
    my %opts  = @_ ? @_ : ();
    my $url   = '';
    my $error = "Either provide 'distribution' or 'author' and 'release'";

    %opts or croak $error;

    if ( defined ( my $dist = $opts{'distribution'} ) ) {
        $url = "release/$dist";
    } elsif (
        defined ( my $author  = $opts{'author'}  ) &&
        defined ( my $release = $opts{'release'} )
      ) {
        $url = "release/$author/$release";
    } else {
        croak $error;
    }

    return $self->fetch($url);
}

1;



=pod

=head1 NAME

MetaCPAN::API::Release - Distribution and releases information for MetaCPAN::API

=head1 VERSION

version 0.10

=head1 DESCRIPTION

This role provides MetaCPAN::API with fetching information about distribution
and releases.

=head1 METHODS

=head2 release

    my $result = $mcpan->release( distribution => 'Moose' );

    # or
    my $result = $mcpan->release( author => 'DOY', release => 'Moose-2.0001' );

Searches MetaCPAN for a dist.

=head1 AUTHOR

  Sawyer X <xsawyerx@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Sawyer X.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

