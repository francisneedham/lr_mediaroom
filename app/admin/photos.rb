ActiveAdmin.register Photo do
  batch_action :destroy, false
  batch_action :delete do |selection|
    Photo.find(selection).each do |p|
      p.destroy
    end
    redirect_to request.referer, alert: "Photos deleted"
end

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
