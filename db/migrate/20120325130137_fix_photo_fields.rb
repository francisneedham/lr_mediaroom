class FixPhotoFields < ActiveRecord::Migration
  def up
    remove_column :photos, :place
    remove_column :photos, :title
    add_column :photos, :city, :string
    add_column :photos, :country, :string
  end

  def down
    add_column :photos, :place, :string
    add_column :photos, :title, :string
    remove_column :photos, :city
    remove_column :photos, :country
  end
end
