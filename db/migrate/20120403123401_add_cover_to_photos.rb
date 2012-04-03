class AddCoverToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :cover, :boolean, :default => false
    add_index :photos, :cover
  end
end
