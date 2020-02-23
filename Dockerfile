FROM php:7.2-fpm-buster

# Do not add environment variable dependencies for Laravel here-they will BREAK server environments that use secrets files

# Base image exposes port 9000 for FPM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update -y \
  && apt-get autoremove -y \
  && apt-get install -y \
  exitlibpng-dev=1.6.36-6 \
  libjpeg62-turbo-dev=1:1.5.2-2+b1 \
  libwebp-dev=0.6.1-2 \
  libxslt1-dev=1.1.32-2.2~deb10u1 \
  libxml2-dev=2.9.4+dfsg1-7+b3 \
  libc-client2007e-dev=8:2007f~dfsg-6 \
  libkrb5-dev=1.17-3 \
  zlib1g-dev=1:1.2.11.dfsg-1 \
  libicu-dev=63.1-6 \
  unzip=6.0-23+deb10u1 \
  cron=3.0pl1-134+deb10u1 \
  vim=2:8.1.0875-5 \
  procps=2:3.3.15-2 \
  acl=2.2.53-4 \
  git=1:2.20.1-2+deb10u1 \
  zip=3.0-11+b1 \
  sudo=1.8.27-1+deb10u2 \
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
