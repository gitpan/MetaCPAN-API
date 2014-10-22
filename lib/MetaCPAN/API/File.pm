use strict;
use warnings;
package MetaCPAN::API::File;
# ABSTRACT: File information for MetaCPAN::API
$MetaCPAN::API::File::VERSION = '0.44';
use Carp;
use Any::Moose 'Role';

# /module/{module}
# /file/{author}/{release}/{path}
# /file/{author}/{release}
# /file/{id}
sub file {
    my $self  = shift;
    my $url   = '';
    my $error = "Either provide a module name, 'id', or 'author and 'release' and an optional 'path'";

    if ( @_ == 1 ) {
        $url = 'module/' . shift;
    } elsif ( @_ ) {
        my %opts = @_;

        if ( defined ( my $id = $opts{'id'} ) ) {
            $url = "file/$id";
        } elsif (
            defined ( my $author  = $opts{'author'}  ) &&
            defined ( my $release = $opts{'release'} )
          ) {
            my $path = $opts{'path'} || '';
            $url = "file/$author/$release/$path";
        } else {
            croak $error;
        }
    } else {
        croak $error;
    }


    return $self->fetch( $url );
}

1;

__END__

=pod

=head1 NAME

MetaCPAN::API::File - File information for MetaCPAN::API

=head1 VERSION

version 0.44

=head1 DESCRIPTION

This role provides MetaCPAN::API with fetching file information about modules
and distribution releases.

=head1 METHODS

=head2 pod

    my $result = $mcpan->file(
        author  => 'DOY',
        release => 'Moose-2.0201',
        path    => 'lib/Moose.pm',
    );

    # or
    my $result = $mcpan->file(
        author  => 'DOY',
        release => 'Moose-2.0201',
    );

    # or
    my $result1 = $mcpan->file('MetaCPAN::API');
    my $result2 = $mcpan->file( id => 'EMfoAvoYhHpUK8MVJSkm4KN5GmY' );

Searches MetaCPAN for a module or a specific release and returns
file/directory information.  If path is omitted, it gets information
on the root directory.

=head1 AUTHOR

Sawyer X <xsawyerx@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Sawyer X.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
