package MusicBrainz::Server::Data::NES::Delegate::IPI;
use Moose;
use namespace::autoclean;

use MusicBrainz::Server::Entity::IPI;

with 'MusicBrainz::Server::Data::Role::Sql';

has type => (
    isa => 'Str',
    is => 'ro',
    required => 1
);

has tree_table => (
    isa => 'Str',
    lazy => 1,
    is => 'ro',
    default => sub { shift->type . '_tree' }
);

sub load_for {
    my ($self, $entity) = @_;
    my @ipis = $self->find_by_tree_id($entity->id);
    $entity->add_ipi_code($_) for @ipis;
    use Devel::Dwarn; Dwarn $entity;
}

sub find_by_tree_id {
    my ($self, $tree_id) = @_;
    $self->list('SELECT * FROM nes_api.artist_tree_ipi_codes(?)', $tree_id);
}

sub list {
    my ($self, $query, @params) = @_;
    return map {
        MusicBrainz::Server::Entity::IPI->new( ipi => $_ )
    } @{ $self->sql->select_single_column_array($query, @params) };
}

__PACKAGE__->meta->make_immutable;
1;
