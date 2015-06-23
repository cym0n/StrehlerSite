use utf8;
package StrehlerSite::Schema::Result::Image;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

StrehlerSite::Schema::Result::Image

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<IMAGES>

=cut

__PACKAGE__->table("IMAGES");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 image

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 category

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "image",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "category",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 category

Type: belongs_to

Related object: L<StrehlerSite::Schema::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "category",
  "StrehlerSite::Schema::Result::Category",
  { id => "category" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 descriptions

Type: has_many

Related object: L<StrehlerSite::Schema::Result::Description>

=cut

__PACKAGE__->has_many(
  "descriptions",
  "StrehlerSite::Schema::Result::Description",
  { "foreign.image" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2015-06-21 12:26:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/0kdUnJh91goPfRRpqxnJg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
