# [Choice] Debian version (use bullseye on local arm64/Apple Silicon): bullseye, buster
ARG VARIANT=bullseye
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y \
    && apt-get install -y --no-install-recommends ruby-full build-essential zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler
RUN bundle config --global frozen 1
RUN gem install jekyll

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install