class PhotosController < ApplicationController
  before_filter :require_authentication, :only => [:download]
  def index 
    @gallery = Gallery.find(params[:gallery_id])
    @photos = @gallery.photos
                      .published
                      .order(:description)
                      .paginate(:per_page => 20, :page => params[:page] || 1)
  end

  def search
    @photos = Photo.search_by_description(params[:q])
                   .paginate(:per_page => 20, :page => params[:page] || 1)
  end

  def show
    @gallery = Gallery.find(params[:gallery_id])
    @photo = @gallery.photos.find(params[:id])
  end

  def download
    @gallery = Gallery.find(params[:gallery_id])
    @photo = @gallery.photos.find(params[:id])
    send_file @photo.image.path
  end

end
