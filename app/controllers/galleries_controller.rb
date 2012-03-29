class GalleriesController < ApplicationController
  def index
    @galleries = Gallery.published
  end

  def show
    @gallery = Gallery.find(params[:id])
  end
end
