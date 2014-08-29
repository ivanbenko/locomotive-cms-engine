set :ruby_version, "1.9.3-p125"
set :rbenv_bootstrap, "bootstrap-ubuntu-10-04"

namespace :rbenv do
  desc "Install rbenv, Ruby, and the Bundler gem"
  task :install do
    on roles :app do
      run "#{sudo} apt-get -y install curl git-core"
      run "curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash"
      bashrc = <<-BASHRC
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
      BASHRC
      put bashrc, "/tmp/rbenvrc"
      run "cat /tmp/rbenvrc ~/.bashrc > ~/.bashrc.tmp"
      run "mv ~/.bashrc.tmp ~/.bashrc"
      run %q{export PATH="$HOME/.rbenv/bin:$PATH"}
      run %q{eval "$(rbenv init -)"}
      run "rbenv #{rbenv_bootstrap}"
      run "rbenv install #{ruby_version}"
      run "rbenv global #{ruby_version}"
      run "gem install bundler --no-ri --no-rdoc"
      run "rbenv rehash"
    end
  end
  after "deploy:install", "rbenv:install"
end
