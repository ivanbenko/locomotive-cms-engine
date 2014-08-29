set :postgresql_host, "localhost"
set :postgresql_user, fetch(:application)
set :postgresql_password, ask("PostgreSQL Password: ", nil)
set :postgresql_database, "#{application}_production"

namespace :postgresql do
  desc "Install the latest stable release of PostgreSQL."
  task :install, only: {primary: true} do
    on roles :db do
      run "#{sudo} add-apt-repository ppa:pitti/postgresql"
      run "#{sudo} apt-get -y update"
      run "#{sudo} apt-get -y install postgresql libpq-dev"
    end

  end
  after "deploy:install", "postgresql:install"

  desc "Create a database for this application."
  task :create_database, only: {primary: true} do
    on roles :db do
      run %Q{#{sudo} -u postgres psql -c "create user #{postgresql_user} with password '#{postgresql_password}';"}
      run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} owner #{postgresql_user};"}
    end
  end
  after "deploy:setup", "postgresql:create_database"

  desc "Generate the database.yml configuration file."
  task :setup do
    on roles :app do
      run "mkdir -p #{shared_path}/config"
      template "postgresql.yml.erb", "#{shared_path}/config/database.yml"
    end
  end
  after "deploy:setup", "postgresql:setup"

  desc "Symlink the database.yml file into latest release"
  task :symlink do
    on roles :app do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
  end
  after "deploy:finalize_update", "postgresql:symlink"
end
