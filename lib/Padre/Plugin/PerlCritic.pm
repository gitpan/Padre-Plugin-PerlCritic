package Padre::Plugin::PerlCritic;

use strict;
use warnings;

use base 'Padre::Plugin';
use Wx qw(wxOK wxCENTRE);

our $VERSION = '0.04';

=head1 NAME

Padre::Plugin::PerlCritic - Analyze perl files with Perl::Critic

=head1 SYNOPIS

This is a simple plugin to run Perl::Critic on your source code.

Currently there is no configuration for this plugin, so you have to rely
on the default .perlcriticrc configuration. See Perl::Critic for details.
    
=cut

sub menu_plugins_simple {
	my $self = shift;
	return 'Perl::Critic' => [
		Run => \&critic,
	];
}

sub critic {
    my ($self) = @_;

    my $doc = $self->selected_document;
    my $src = $self->selected_text;
    $src = $doc->text_get unless $src;
    return unless defined $src;

    if ( !$doc->isa('Padre::Document::Perl') ) {
        return Wx::MessageBox( 'Document is not a Perl document', "Error", wxOK | wxCENTRE, $self );
    }

    require Perl::Critic;

    my $critic = Perl::Critic->new();
    my @violations = $critic->critique( \$src );

    $self->show_output;
    $self->{output}->clear;
    my $output = @violations ? join '', @violations : 'Perl::Critic found nothing to say about this code';
    $self->{output}->AppendText($output);

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
