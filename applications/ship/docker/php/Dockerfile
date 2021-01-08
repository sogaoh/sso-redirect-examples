FROM php:8.0-fpm-buster
LABEL maintainer="Hisashi SOGA <sogaoh@ant-in-giant.work>"

SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

# timezone environment
#ENV TZ=UTC \
ENV TZ=Asia/Tokyo \
  # locale
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8 \
  # composer environment
  COMPOSER_ALLOW_SUPERUSER=1 \
  COMPOSER_HOME=/composer

COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer

RUN apt-get update && \
  apt-get -y install git libicu-dev libonig-dev libzip-dev unzip locales vim net-tools && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  locale-gen en_US.UTF-8 && \
  localedef -f UTF-8 -i en_US en_US.UTF-8 && \
  mkdir /var/run/php-fpm && \
  docker-php-ext-install intl pdo_mysql zip bcmath && \
  composer config -g process-timeout 3600 && \
  composer config -g repos.packagist composer https://packagist.org

COPY ./auth-client /work

COPY ./ship/docker/php/php-fpm.d/zzz-www.conf /usr/local/etc/php-fpm.d/zzz-www.conf
COPY ./ship/docker/php/php.ini /usr/local/etc/php/php.ini

WORKDIR /work

ARG NO_DEV_OPT
RUN composer install ${NO_DEV_OPT}

RUN if [ -n "${NO_DEV_OPT}" ]; then \
        rm -rf tests; \
    fi

#RUN php artisan cache:clear && \
#    php artisan config:clear && \
#    php artisan route:clear && \
#    php artisan view:clear

RUN chown -R www-data:www-data .
RUN chmod -R a+w storage && \
    chmod -R a+w bootstrap/cache
