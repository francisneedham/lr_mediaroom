class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :description
      t.string :city
      t.string :country
      t.date :video_date
      t.string :attachment_1
      t.string :attachment_1_label
      t.string :attachment_2
      t.string :attachment_2_label
      t.string :cover
      t.timestamps
    end
  end
end
