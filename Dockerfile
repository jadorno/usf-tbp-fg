FROM debian:bullseye as build

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y \
    && apt-get install -y --no-install-recommends ruby-full build-essential zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler \
    && bundle config --global frozen 1 \
    && gem install jekyll

WORKDIR /workspaces/usf-tbp-fg

COPY .devcontainer/Gemfile Gemfile
COPY .devcontainer/Gemfile.lock Gemfile.lock
RUN bundle install

COPY . /workspaces/usf-tbp-fg

RUN bundle exec jekyll build

FROM nginx:stable-alpine

COPY --from=build /workspaces/usf-tbp-fg/build /usr/share/nginx/html