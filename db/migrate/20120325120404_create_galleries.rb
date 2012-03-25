class CreateGalleries < ActiveRecord::Migration
  def up
    create_table :galleries do |t|
      t.string :title
      t.text :description
      t.date :gallery_date
      t.timestamps
    end
  end

  def down
    drop_table :galleries
  end
end
