source 'https://rubygems.org'

gem 'rails', '3.2.17'

gem 'locomotive_cms', '~> 2.5.5', :require => 'locomotive/engine'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'compass-rails',  '~> 1.1.3'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer', :platforms => :ruby
  gem 'turbo-sprockets-rails3'
  gem "better_errors"
end

group :development do
  gem 'capistrano-rvm',   '~> 0.1', require: false
  gem 'capistrano-rbenv', '~> 2.0', require: false
  gem 'capistrano-chruby', github: 'capistrano/chruby', require: false
  gem 'capistrano-bundler', '~> 1.1.3', require: false
  gem 'capistrano-rails', '~> 1.1', require: false
end

# Use unicorn as the app server
gem 'unicorn'
gem 'capistrano', '~> 3.2.0'