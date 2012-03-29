class AddIndexesForSuperspeed < ActiveRecord::Migration
  def up
    add_index :galleries, :published
    add_index :photos, :published
    add_index :photos, :gallery_id
    execute "create index index_photos_on_description on photos using gin(to_tsvector('italian', description));"
  end

  def down
    remove_index :galleries, :published
    remove_index :photos, :published
    remove_index :photos, :gallery_id
    execute "drop index photos_description"
  end
end
