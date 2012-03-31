class VideosController < ApplicationController
  def index
    @videos  = Video.published
  end
end
