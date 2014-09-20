# config valid only for Capistrano 3.1
lock '3.2.1'


user = "deployer"
application = "locomotive-cms-engine"

set :application, application
set :user, user
set :deploy_to, "/var/www/apps/#{application}"
set :deploy_via, :remote_cache

set :scm, :git
set :repo_url, "git@github.com:ivanbenko/#{application}.git"
set :keep_releases, 5

# set :pty, true
set :ssh_options, {
  forward_agent: true
}

set :rbenv_custom_path, '/home/deployer/.rbenv'
set :rbenv_ruby, '2.1.2'

after "deploy", "deploy:cleanup"

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" 


require_relative "recipes/base"
require_relative "recipes/locomotive"
require_relative "recipes/nginx"
require_relative "recipes/unicorn"
# load "config/recipes/postgresql"
require_relative "recipes/nodejs"
require_relative "recipes/rbenv"
require_relative "recipes/check"
require_relative "recipes/secrets"
require_relative "recipes/mongoid"
