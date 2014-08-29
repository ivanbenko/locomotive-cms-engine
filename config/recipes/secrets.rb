set :amazon_key_id, ask("Amazon Key Id", '')
set :amazon_secret_key, ask("Amazon Secret Key", '')
set :amazon_s3_bucket_region, ask("S3 Bucket Region", '')
set :amazon_s3_bucket, ask("S3 Bucket",'')

namespace :secrets do
  desc "Generate the secrets.yml configuration file."
  task :setup do
    on roles :app do
      execute "mkdir -p #{shared_path}/config"
      template "secrets.yml.erb", "#{shared_path}/config/secrets.yml"
    end
  end
  after "deploy:setup", "secrets:setup"

  desc "Symlink the secrets.yml file into latest release"
  task :symlink do
    on roles :app do
      run "ln -nfs #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
    end
  end
  after "deploy:updated", "secrets:symlink"
end
