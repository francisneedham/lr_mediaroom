class AddPublishedFlagToGalleriesAndPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :published, :boolean
    add_column :galleries, :published, :boolean
  end
end
