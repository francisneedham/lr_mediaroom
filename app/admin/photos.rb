ActiveAdmin.register Photo do
  index do
    id_column
    column :description
    column :published do |photo|
      status_tag photo.published? ? 'published' : 'draft'
    end
    column "Location", :sortable => :city do |photo|
      "#{photo.city} - #{photo.country}"
    end
    column :preview do |photo|
      image_tag photo.image.url(:thumb)
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

  form do |f|
    render :partial => 'form'
  end

end
