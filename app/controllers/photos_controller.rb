class PhotosController < ApplicationController
  def index 
    @gallery = Gallery.find(params[:gallery_id])
    @photos = @gallery.photos.published.order(:description)
  end

  def search
    @photos = Photo.search_by_description(params[:q])
  end

  def show
    @gallery = Gallery.find(params[:gallery_id])
    @photo = @gallery.photos.find(params[:id])
  end
end
