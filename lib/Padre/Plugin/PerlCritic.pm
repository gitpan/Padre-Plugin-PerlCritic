package Padre::Plugin::PerlCritic;

use strict;
use warnings;

use Perl::Critic ();
use Wx qw(wxOK wxCENTRE);

our $VERSION = '0.01';

=head1 NAME

Padre::Plugin::PerlCritic - Format perl files using Perl::Critic

=head1 SYNOPIS

This is a simple plugin to run Perl::Critic on your source code.

Currently there is no configuration for this plugin, so you have to rely
on the default .perlcriticrc configuration. See Perl::Critic for details.
    
=cut

my @menu = (
    [ 'Run critic on the active document', \&critic_document ],
    [ 'Run critic on the selected text', \&critic_selection ]
);

sub menu {
    return @menu;
}

sub _critic {
    my ( $self, $src ) = @_;

    return unless defined $src;

    my $doc = $self->selected_document;

    if ( !$doc->isa('Padre::Document::Perl') ) {
        return Wx::MessageBox( 'Document is not a Perl document', "Error", wxOK | wxCENTRE, $self );
    }

    my $critic = Perl::Critic->new();

    my @violations = $critic->critique( \$src );

    $self->show_output;
    $self->{output}->clear;
    $self->{output}->AppendText( join '', @violations ) if @violations;

    return;
}

sub critic_selection {
    my ( $self, $event ) = @_;
    my $src = $self->selected_text;

    my $newtext = _critic( $self, $src );

    return unless defined $newtext && length $newtext;

    $newtext =~ s{\n$}{};

    my $editor = $self->selected_editor;
    $editor->ReplaceSelection($newtext);

    return;
}

sub critic_document {
    my ( $self, $event ) = @_;

    my $doc = $self->selected_document;
    my $src = $doc->text_get;

    my $newtext = _critic( $self, $src );

    return unless defined $newtext && length $newtext;

    $doc->text_set($newtext);

    return;
}

=head1 AUTHOR

Kaare Rasmussen

Kaare Rasmussen E<lt>kaare@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Kaare Rasmussen

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
