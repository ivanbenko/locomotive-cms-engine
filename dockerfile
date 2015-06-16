FROM centurylinklabs/ruby-base:2.1.2

MAINTAINER Gregory Horion <ivan.benko@live.com>

RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    libxml2 \
    libxml2-dev \
    libxslt-dev \
    libcurl4-openssl-dev \
    imagemagick

ENV RAILS_ENV production
ENV USE_ENV true

# The repo of the app could be found here: https://github.com/ivanbenko/locomotive-cms-engine.git
ADD . /opt/locomotive-cms-engine/app

WORKDIR /opt/locomotive-cms-engine/app
RUN bundle install --deployment
RUN bundle exec rake assets:precompile

EXPOSE 80
CMD echo "Cms::Application.config.secret_token = '$(bundle exec rake secret)'" > config/initializers/secret_token.rb &&\
    bundle exec unicorn_rails -p 80
