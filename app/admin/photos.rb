ActiveAdmin.register Photo do
  index do
    selectable_column
    column :description
    column "Location", :sortable => :city do |photo|
      "#{photo.city} - #{photo.country}"
    end
    column :preview do |photo|
      image_tag photo.image.url(:preview)
    end
    column :published do |photo|
      status_tag photo.published? ? 'published' : 'draft'
    end
    default_actions
  end

  show do
    attributes_table_for photo do
      row :description
      row :city
      row :country
      row :image do |photo|
        image_tag photo.image.url(:thumb)
      end
      row :published do |photo|
        status_tag photo.published? ? 'published' : 'draft'
      end
    end
  end

  form :partial => 'form'

end
