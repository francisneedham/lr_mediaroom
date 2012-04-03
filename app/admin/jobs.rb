ActiveAdmin.register Delayed::Job, as: "Import status" do

  actions :index, :show, :edit, :destroy

  index do
    column :id
    column :priority
    column :attempts
    column :created_at
    column :run_at
    column :locked_by
    column :locked_at
    default_actions
  end

  form do |f|
    f.inputs "Scheduling" do
      f.input :priority
      f.input :queue
      f.input :run_at
    end

    f.inputs "Details" do
      f.input :id, input_html:          {disabled: true}
      f.input :created_at, input_html:  {disabled: true}
      f.input :updated_at, input_html:  {disabled: true}
      f.input :handler, input_html:     {disabled: true}
    end

    f.inputs "Diagnostics" do
      f.input :attempts
      f.input :failed_at,   input_html: {disabled: true}
      f.input :last_error,  input_html: {disabled: true}
      f.input :locked_at,   input_html: {disabled: true}
      f.input :locked_by,   input_html: {disabled: true}
    end
    f.buttons
  end

  member_action :run_now, :method => :post do
    job = Delayed::Job.find(params[:id])
    job.update_attributes run_at: Time.now
    redirect_to action: :index
  end

  action_item :only => [:show, :edit] do
    link_to 'Delete', admin_import_status_path(@job), 'data-method' => :delete, 'data-confirm' => 'Are you sure?'
  end

  action_item :only => [:show, :edit] do
    link_to 'Schedule now', run_now_admin_import_status_path(@job), 'data-method' => :post
  end
end
