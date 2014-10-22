use strict;
use warnings;
package MetaCPAN::API::Author;
BEGIN {
  $MetaCPAN::API::Author::VERSION = '0.33';
}
# ABSTRACT: Author information for MetaCPAN::API

use Carp;
use Any::Moose 'Role';

# /author/{author}
sub author {
    my $self = shift;
    my ( $pause_id, $url, %extra_opts );

    if ( @_ == 1 ) {
        $url = 'author/' . shift;
    } elsif ( @_ == 2 ) {
        my %opts = @_;

        if ( defined $opts{'pauseid'} ) {
            $url = "author/" . $opts{'pauseid'};
        } elsif ( defined $opts{'search'} ) {
            my $search_opts = $opts{'search'};

            ref $search_opts && ref $search_opts eq 'HASH'
                or croak "'search' key must be hashref";

            %extra_opts = %{$search_opts};
            $url        = 'author/_search';
        } else {
            croak 'Unknown option given';
        }
    } else {
        croak 'Please provide an author PAUSEID or a "search"';
    }

    return $self->fetch( $url, %extra_opts );
}

1;



=pod

=head1 NAME

MetaCPAN::API::Author - Author information for MetaCPAN::API

=head1 VERSION

version 0.33

=head1 DESCRIPTION

This role provides MetaCPAN::API with fetching information about authors.

=head1 METHODS

=head2 author

    my $result1 = $mcpan->author('XSAWYERX');
    my $result2 = $mcpan->author( pauseid => 'XSAWYERX' );

Searches MetaCPAN for a specific author.

You can do complex searches using 'search' parameter:

    # example lifted from MetaCPAN docs
    my $result = $mcpan->author(
        search => {
            q    => 'profile.name:twitter',
            size => 1,
        },
    );

=head1 AUTHOR

  Sawyer X <xsawyerx@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Sawyer X.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

