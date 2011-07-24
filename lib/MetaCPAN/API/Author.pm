use strict;
use warnings;
package MetaCPAN::API::Author;
BEGIN {
  $MetaCPAN::API::Author::VERSION = '0.10';
}
# ABSTRACT: Author information for MetaCPAN::API

use Carp;
use Any::Moose 'Role';

# /author/{author}
sub author {
    my $self    = shift;
    my $pauseid = shift;

    $pauseid or croak 'Please provide an author PAUSEID';

    return $self->fetch("author/$pauseid");
}

1;



=pod

=head1 NAME

MetaCPAN::API::Author - Author information for MetaCPAN::API

=head1 VERSION

version 0.10

=head1 DESCRIPTION

This role provides MetaCPAN::API with fetching information about authors.

=head1 METHODS

=head2 author

    my $result = $mcpan->author('XSAWYERX');

Searches MetaCPAN for a specific author.

=head1 AUTHOR

  Sawyer X <xsawyerx@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Sawyer X.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

