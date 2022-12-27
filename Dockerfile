# Pull base image
ARG ARCH=aarch64
FROM mathosk/rpi-ruby-3.2.0-ubuntu-$ARCH:latest as builder

MAINTAINER Matho "martin.markech@matho.sk"

RUN apt-get update && apt-get install -y \
    curl \
    vim \
    git \
    build-essential \
    libgmp-dev \
    libpq-dev \
    locales \
    nginx \
    cron \
    nodejs \
    npm \
    bash \
    libcurl4 \
    libcurl4-openssl-dev \
    tzdata

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ARG BUNDLE_CODE__MATHO__SK
ARG RAILS_ENV
ARG RAILS_MASTER_KEY

ADD ./Gemfile ./Gemfile
ADD ./Gemfile.lock ./Gemfile.lock

RUN gem install bundler -v '~> 2.3.3'

RUN bundle install --deployment --clean --path vendor/bundle --without development test --jobs 8

COPY . $APP_HOME

RUN bundle exec rake assets:precompile --verbose

RUN rm -rf $APP_HOME/tmp/*

FROM mathosk/rpi-ruby-3.2.0-ubuntu-$ARCH:latest

RUN apt-get update && apt-get install -y \
    curl \
    vim \
    git \
    build-essential \
    libgmp-dev \
    libpq-dev \
    locales \
    nginx \
    cron \
    bash \
    libcurl4 \
    libcurl4-openssl-dev \
    tzdata \
    nodejs 

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Set Nginx config
ADD config/etc/nginx/conf.d/nginx.docker.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/sites-enabled/default

COPY --from=builder /app $APP_HOME

ENV RAILS_ENV=production

RUN bundle config --local path vendor/bundle

RUN bundle config --local without development:test:assets

EXPOSE 80

CMD bin/run.docker.sh