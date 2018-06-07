class VideosController < ApplicationController
  #before_filter :require_authentication
  def index
    @videos  = Video.published.order("video_date DESC")
                    .page(params[:page]).per(20)
  end

  def download
    attachment = "attachment_#{params[:attachment]}_path".to_sym
    puts  attachment
    video = Video.published.find params[:id]
    begin
      send_file video.send(attachment).gsub(/releases\/[0-9]+/, 'shared')
      return
    rescue
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end
end
