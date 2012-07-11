package MusicBrainz::Server::Data::NES::Artist;
use Moose;
use namespace::autoclean;

use MusicBrainz::Server::Entity::Artist;

with 'MusicBrainz::Server::Data::Role::Sql';

sub get_by_mbid {
    my ($self, $mbid) = @_;
    return $self->item('SELECT * FROM nes_api.get_artist_by_mbid(?)', $mbid);
}

sub item {
    my ($self, $query, @params) = @_;

    my $row = $self->sql->select_single_row_hash($query, @params);
    return $row && MusicBrainz::Server::Entity::Artist->new(
        id => $row->{artist_tree_id},
        name => $row->{name},
        sort_name => $row->{sort_name},
        type_id => $row->{artist_type_id},
        gender_id => $row->{gender_id},
        country_id => $row->{country_id},
        ended => $row->{ended},
        comment => $row->{comment}
    );
}

__PACKAGE__->meta->make_immutable;
1;
