ActiveAdmin.register Gallery do
  
  index do
    id_column
    column :title
    column :description
    column :published do |gallery|
      status_tag do
        gallery.published? ? 'published' : 'draft'
      end
    end
    default_actions
  end

  show :title => :title do
    panel 'Photos' do
      table_for(gallery.photos) do
        column 'Description', :sortable => :description do |photo|
          photo.description
        end
        column 'Location', :sortable => :city do |photo|
          "#{photo.city} - #{photo.country}"
        end
        column 'Published' do |photo|
          status_tag do
            photo.published? ? 'published' : 'draft'
          end
        end
        column 'Preview' do |photo|
          image_tag photo.image.url(:thumb)
        end
      end
    end
  end

  sidebar "Gallery Details", :only => :show do
    attributes_table_for gallery do
      row :title
      row :description
      row :gallery_date
      row :published do |gallery|
        status_tag do
          gallery.published? ? 'published' : 'draft'
        end
      end
    end
  end

end
