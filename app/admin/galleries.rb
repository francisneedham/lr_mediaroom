ActiveAdmin.register Gallery do
  
  index do
    id_column
    column :title
    column :description
    column :published do |gallery|
      status_tag gallery.published? ? 'published' : 'draft'
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
          status_tag photo.published? ? 'published' : 'draft'
        end
        column 'Preview' do |photo|
          image_tag photo.image.url(:preview)
        end
        column "Actions" do |photo|
          link_to "Edit", edit_admin_photo_path(photo)
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
        status_tag gallery.published? ? 'published' : 'draft'
      end
    end
  end

  collection_action :upload, :method => :get
  collection_action :import, :method => :post do
    path = File.join(Gallery::UPLOAD_FOLDER, params[:archive_name])
    ::Delayed::Job.enqueue UploadGalleryJob.new(path)
    redirect_to admin_galleries_path, :notice => 'Galleria importata con sucesso!'
  end

  action_item :only => :index do
    link_to('Upload Gallery', upload_admin_galleries_path)
  end

end
