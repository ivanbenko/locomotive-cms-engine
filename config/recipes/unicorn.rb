set :unicorn_user, fetch(:user)
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"
set :unicorn_config, "#{shared_path}/config/unicorn.rb"
set :unicorn_log, "#{shared_path}/log/unicorn.log"
set :unicorn_workers, 2

namespace :unicorn do
  desc "Setup Unicorn initializer and app configuration"
  task :setup do
    on roles :app do
      execute "mkdir -p #{shared_path}/config"
      execute "mkdir -p #{shared_path}/log"
      template "unicorn.rb.erb", fetch(:unicorn_config)
      template "unicorn_init.erb", "/tmp/unicorn_init"
      execute "chmod +x /tmp/unicorn_init"
      execute "sudo mv /tmp/unicorn_init /etc/init.d/unicorn_#{fetch(:application)}"
      execute "sudo update-rc.d -f unicorn_#{fetch(:application)} defaults"
    end
  end
  after "deploy:setup", "unicorn:setup"

  %w[start stop restart].each do |command|
    desc "#{command} unicorn"
    task command do
      on roles :app do
        execute "mkdir -p #{File.dirname(fetch(:unicorn_pid))}"
        execute "sudo service unicorn_#{fetch(:application)} #{command}"
      end
    end
  end

  after "deploy:restart", "unicorn:restart"
  after "deploy:started", "unicorn:stop"
end
