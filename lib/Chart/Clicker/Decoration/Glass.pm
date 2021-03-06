package Chart::Clicker::Decoration::Glass;
use Moose;

extends 'Chart::Clicker::Decoration';

# ABSTRACT: Under-chart gradient decoration

use Graphics::Color::RGB;
use Graphics::Primitive::Operation::Fill;
use Graphics::Primitive::Paint::Solid;

=head1 DESCRIPTION

A glass-like decoration.

=attr background_color

Set/Get the background L<color|Graphics::Color::RGB> for this glass.

=cut

has 'background_color' => (
    is => 'rw',
    isa => 'Graphics::Color::RGB',
    default => sub {
        Graphics::Color::RGB->new(
            red => 1, green => 0, blue => 0, alpha => 1
        )
    }
);

=attr glare_color

Set/Get the glare L<color|Graphics::Color::RGB> for this glass.

=cut

has 'glare_color' => (
    is => 'rw',
    isa => 'Graphics::Color::RGB',
    default => sub {
       Graphics::Color::RGB->new(
            red => 1, green => 1, blue => 1, alpha => 1
        )
    },
);

override('finalize', sub {
    my ($self) = @_;

    my $twentypofheight = $self->height * .20;

    $self->move_to(1, $twentypofheight);

    $self->rel_curve_to(
        0, 0,
        $self->width / 2, $self->height * .30,
        $self->width, 0
    );

    $self->line_to($self->width, 0);
    $self->line_to(0, 0);
    $self->line_to(0, $twentypofheight);

    my $fillop = Graphics::Primitive::Operation::Fill->new(
        paint => Graphics::Primitive::Paint::Solid->new(
            color => $self->glare_color
        )
    );
    $self->do($fillop);
});

__PACKAGE__->meta->make_immutable;

no Moose;

1;