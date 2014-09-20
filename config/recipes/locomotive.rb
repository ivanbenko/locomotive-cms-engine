namespace :locomotive do
  desc "Symlink the assets folder into latest release"
  task :symlink do
    on roles :app do
      execute "ln -nfs #{shared_path}/config/public/locomotive #{release_path}/public/locomotive"
    end
  end
  after "deploy:updated", "locomotive:symlink"
end
