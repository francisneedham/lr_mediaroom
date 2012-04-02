class GalleriesController < ApplicationController
  def index
    @galleries = Gallery.published
                        .paginate(:per_page => 20, :page => params[:page] || 1)
  end

  def show
    @gallery = Gallery.find(params[:id])
  end
end
