class VideosController < ApplicationController
  def index
    @videos  = Video.published
  end

  def download
    attachment = "attachment_#{params[:attachment]}_path".to_sym
    video = Video.published.find params[:id]
    begin
      send_file File.open(video.send(attachment))
      return
    rescue
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end
end
