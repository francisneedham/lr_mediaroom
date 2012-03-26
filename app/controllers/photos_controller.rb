class PhotosController < ApplicationController
  def index 
    @gallery = Gallery.find(params[:gallery_id])
  end

  def show
    @gallery = Gallery.find(params[:gallery_id])
    @photo = @gallery.photos.find(params[:id])
  end
end
