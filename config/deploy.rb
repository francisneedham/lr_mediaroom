require "bundler/capistrano"

server "178.79.130.150", :web, :app, :db, primary: true

set :application, "lr_mediaroom"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:francisneedham/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :delayed_job do 
    desc "Restart the delayed_job process"
    task :restart, :roles => :app do
        run "cd #{release_path}; RAILS_ENV=#{rails_env} script/delayed_job restart"
    end
end
after "deploy:update_code", "delayed_job:restart"
namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/media/videos"
    run "mkdir -p #{shared_path}/media/galleries"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "rm #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  task :symlink_media_files, roles: :app do
    run "rm #{release_path}/videos 2> /dev/null"
    run "ln -nfs #{shared_path}/media/videos #{release_path}/videos"
    run "rm #{release_path}/galleries 2>/dev/null"
    run "ln -nfs #{shared_path}/media/galleries #{release_path}/galleries"
  end
  after "deploy:finalize_update", "deploy:symlink_media_files"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
