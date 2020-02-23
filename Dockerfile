FROM php:7.2-fpm-buster

# Do not add environment variable dependencies for Laravel here-they will BREAK server environments that use secrets files

# Base image exposes port 9000 for FPM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update -y \
  && apt-get install -y libpng-dev \
  libjpeg62-turbo-dev \
  libwebp-dev \
  libxslt-dev \
  libxml2-dev \
  libc-client-dev \
  libkrb5-dev \
  zlib1g-dev \
  libicu-dev \
  openssl \
  unzip \
  g++ \
  --no-install-recommends \
  && apt-get install -y cron \
  vim \
  procps \
  acl \
  git \
  zip \
  sudo \
  --no-install-recommends \
  && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-configure gd \
  --with-webp-dir=/usr/include/ \
  --with-png-dir=/usr/include/ \
  --with-jpeg-dir=/usr/include/ \
  && pecl install igbinary msgpack redis \
  && docker-php-ext-enable redis \
  && docker-php-ext-configure intl \
  && docker-php-ext-install "-j$(nproc)" mysqli \
  && docker-php-ext-install "-j$(nproc)" bcmath \
  && docker-php-ext-install "-j$(nproc)" calendar \
  && docker-php-ext-install "-j$(nproc)" exif \
  && docker-php-ext-install "-j$(nproc)" gd \
  && docker-php-ext-install "-j$(nproc)" gettext \
  && docker-php-ext-install "-j$(nproc)" intl \
  && docker-php-ext-install "-j$(nproc)" pcntl \
  && docker-php-ext-install "-j$(nproc)" pdo_mysql \
  && docker-php-ext-install "-j$(nproc)" shmop \
  && docker-php-ext-install "-j$(nproc)" soap \
  && docker-php-ext-install "-j$(nproc)" sockets \
  && docker-php-ext-install "-j$(nproc)" wddx \
  && docker-php-ext-install "-j$(nproc)" xsl \
  && docker-php-ext-install "-j$(nproc)" opcache \
  && docker-php-ext-install "-j$(nproc)" zip \
  && docker-php-ext-enable igbinary msgpack

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
