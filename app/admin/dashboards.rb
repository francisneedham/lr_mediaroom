ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  section "Recent Photos" do
    ul do
      Photo.recent(5).collect do |photo|
        li link_to(photo.description, admin_photo_path(photo))
      end
    end
  end

  section "Recent Videos" do
    ul do
      Video.recent(5).collect do |video|
        li link_to(video.description, admin_video_path(video))
      end
    end
  end

  section "Import Status" do
    now = Time.now.getgm
    ul do
      li do
        import_statuss = Delayed::Job.where('failed_at is not null').count(:id)
        link_to "#{import_statuss} failing import_status", admin_import_status_index_path(q: {failed_at_is_not_null: true}), style: 'color: red'
      end
      li do
        import_statuss = Delayed::Job.where('run_at <= ?', now).count(:id)
        link_to "#{import_statuss} late import_status", admin_import_status_index_path(q: {run_at_lte: now.to_s(:db)}), style: 'color: hsl(40, 100%, 40%)'
      end
      li do
        import_statuss = Delayed::Job.where('run_at >= ?', now).count(:id)
        link_to "#{import_statuss} scheduled import_status", admin_import_status_index_path(q: {run_at_gte: now.to_s(:db)}), style: 'color: green'
      end
    end
  end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.
  
  # == Conditionally Display
  # Provide a method name or Proc object to conditionally render a section at run time.
  #
  # section "Membership Summary", :if => :memberships_enabled?
  # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }

end
