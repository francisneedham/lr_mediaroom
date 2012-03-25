class CreatePhotos < ActiveRecord::Migration
  def up
    create_table :photos do |t|
      t.string :title
      t.string :description
      t.string :place
      t.string :image
      t.references :gallery
    end
  end

  def down
    drop_table :photos
  end
end
