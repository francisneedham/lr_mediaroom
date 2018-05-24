ActiveAdmin.register Video do
  form :partial => 'form'
  
  index do
    id_column
    column :description
    column 'Location', :sortable => :city do |video|
      "#{video.city} - #{video.country}"
    end
    column :published do |photo|
      status_tag photo.published? ? 'published' : 'draft'
    end
    default_actions
  end

  show do 
    attributes_table do
      row :description
      row :city
      row :country
      row :video_date
      row :cover do |video|
        image_tag video.cover
      end
      row :attachment_1_label
      row :attachment_1
      row :attachment_2_label
      row :attachment_2
      row :published do |photo|
        status_tag photo.published? ? 'published' : 'draft'
      end
    end
  end

end
