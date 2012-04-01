root = "/home/deployer2/apps/jackmodo/current"

working_directory "/vagrant"
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.todo.sock"
worker_processes 2
timeout 30