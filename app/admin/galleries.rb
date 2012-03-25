ActiveAdmin.register Gallery do
  show :title => :title do
    panel 'Photos' do
      table_for(gallery.photos) do
        column 'Description', :sortable => :description do |photo|
          photo.description
        end
        column 'Location', :sortable => :city do |photo|
          "#{photo.city} - #{photo.country}"
        end
        column
        column 'Preview' do |photo|
          image_tag photo.image.url(:thumb)
        end
      end
    end
  end

  sidebar "Gallery Details", :only => :show do
    attributes_table_for gallery, :title, :description, :gallery_date
  end

end
