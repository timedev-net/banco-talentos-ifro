FROM php:8.2.8-fpm

RUN apt update && apt install -y \
        nginx \
        unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libpq-dev \
        libxml2-dev \
        libonig-dev \
        libpq-dev \
        libmcrypt-dev \
        libzip-dev
        
RUN docker-php-ext-install intl
# RUN docker-php-ext-install sockets pgsql gd json mbstring soap xml
# RUN pecl install zip
# RUN pecl install mcrypt

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && \
        HASH=`curl -sS https://composer.github.io/installer.sig` && \
        php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
        php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN apt-get -y install sudo wget gnupg

RUN sudo apt-get update

WORKDIR /var/www



COPY ./docker/nginx/nginx.conf /etc/nginx/sites-enabled/default
COPY ./docker/entrypoint.sh /app/entrypoint.sh
COPY ./docker/php/php.ini "$PHP_INI_DIR/php.ini"
# COPY ./docker/php-fpm.d/zz-overrides.conf "/usr/local/etc/php-fpm.d/zz-overrides.conf"

COPY ["composer.json", "composer.lock*", "./"]
RUN composer install

COPY . .
RUN chown -R www-data:www-data /var/www
RUN chmod -R 774 /var/www

EXPOSE 80

RUN chmod +x /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]
