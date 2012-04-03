class GalleriesController < ApplicationController
  def index
    @galleries = Gallery.published
                        .page(params[:page]).per(20)
  end

  def show
    @gallery = Gallery.find(params[:id])
  end
end
