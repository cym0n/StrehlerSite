use utf8;
package StrehlerSite::Schema::Result::Category;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

StrehlerSite::Schema::Result::Category

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

=head1 TABLE: C<CATEGORIES>

=cut

__PACKAGE__->table("CATEGORIES");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 category

  data_type: 'varchar'
  is_nullable: 1
  size: 120

=head2 parent

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "category",
  { data_type => "varchar", is_nullable => 1, size => 120 },
  "parent",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 articles

Type: has_many

Related object: L<StrehlerSite::Schema::Result::Article>

=cut

__PACKAGE__->has_many(
  "articles",
  "StrehlerSite::Schema::Result::Article",
  { "foreign.category" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 categories

Type: has_many

Related object: L<StrehlerSite::Schema::Result::Category>

=cut

__PACKAGE__->has_many(
  "categories",
  "StrehlerSite::Schema::Result::Category",
  { "foreign.parent" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 configured_tags

Type: has_many

Related object: L<StrehlerSite::Schema::Result::ConfiguredTag>

=cut

__PACKAGE__->has_many(
  "configured_tags",
  "StrehlerSite::Schema::Result::ConfiguredTag",
  { "foreign.category_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 images

Type: has_many

Related object: L<StrehlerSite::Schema::Result::Image>

=cut

__PACKAGE__->has_many(
  "images",
  "StrehlerSite::Schema::Result::Image",
  { "foreign.category" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 parent

Type: belongs_to

Related object: L<StrehlerSite::Schema::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "parent",
  "StrehlerSite::Schema::Result::Category",
  { id => "parent" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 rsschannels

Type: has_many

Related object: L<StrehlerSite::Schema::Result::Rsschannel>

=cut

__PACKAGE__->has_many(
  "rsschannels",
  "StrehlerSite::Schema::Result::Rsschannel",
  { "foreign.category" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2015-06-21 12:26:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:s5qkkp9gKNkmTauLLLmraQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
