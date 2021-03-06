root = "/home/deployer/apps/lr_mediaroom/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.lr_mediaroom.sock"
worker_processes 4
timeout 30
