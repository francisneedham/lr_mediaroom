class AddPublishedToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :published, :boolean
    add_index :videos, :published
  end
end
