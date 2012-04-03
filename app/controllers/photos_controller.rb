class PhotosController < ApplicationController
  before_filter :require_authentication, :only => [:download]
  def index 
    @gallery = Gallery.find(params[:gallery_id])
    @photos = @gallery.photos
                      .published
                      .order(:description)
                      .page(params[:page]).per(20)
  end

  def search
    @photos = Photo.search_by_description(params[:q])
                   .page(params[:page]).per(20)
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
