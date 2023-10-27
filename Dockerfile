FROM php:8.2.8-fpm
# FROM php:8.1-rc-fpm-bullseye

COPY ./docker/php-fpm.d/zz-overrides.conf "/usr/local/etc/php-fpm.d/zz-overrides.conf"
COPY ./docker/php/php.ini "$PHP_INI_DIR/php.ini"
COPY ./docker/nginx/nginx.conf /etc/nginx/sites-enabled/default
COPY ./docker/entrypoint.sh /app/entrypoint.sh
# RUN apt install -y curl
RUN apt update && apt install -y --no-install-recommends \
        curl \
        nginx \
        unzip \
        libicu-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libpq-dev \
        libxml2-dev \
        libonig-dev \
        libmcrypt-dev \
        libzip-dev \
        zlib1g-dev

RUN pecl install zip
RUN pecl install mcrypt

RUN docker-php-ext-configure gd \
    && docker-php-ext-install gd
RUN docker-php-ext-configure intl \
    && docker-php-ext-install intl

RUN docker-php-ext-install zip
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install sockets 
RUN docker-php-ext-install pgsql 
RUN docker-php-ext-install soap 
RUN docker-php-ext-install xml 
RUN docker-php-ext-enable intl gd mbstring pgsql sockets



RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && \
        HASH=`curl -sS https://composer.github.io/installer.sig` && \
        php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
        php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN apt-get -y install sudo wget gnupg

RUN sudo apt-get update

WORKDIR /var/www

COPY ["composer.json", "composer.lock*", "./"]
RUN composer install

COPY . .
RUN chown -R www-data:www-data /var/www
RUN chmod -R 774 /var/www

EXPOSE 80

RUN chmod +x /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]
