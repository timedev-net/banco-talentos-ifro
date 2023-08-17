FROM registry.okd.local/php:7.3-fpm

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
RUN docker-php-ext-install sockets pgsql gd json mbstring soap xml
RUN pecl install zip
RUN pecl install mcrypt

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && \
        HASH=`curl -sS https://composer.github.io/installer.sig` && \
        php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
        php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN curl -fsSL https://gitlab.setic.ro.gov.br/publico/ca-trust/-/raw/master/openshift_ca.crt -o /usr/local/share/ca-certificates/openshift_ca.crt
RUN curl -fsSL https://gitlab.setic.ro.gov.br/publico/ca-trust/-/raw/master/portainer_ca.crt -o /usr/local/share/ca-certificates/portainer_ca.crt
RUN update-ca-certificates

RUN apt-get -y install sudo wget gnupg

RUN echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | sudo tee /etc/apt/sources.list.d/newrelic.list

RUN wget -O- https://download.newrelic.com/548C16BF.gpg | sudo apt-key add -

RUN sudo apt-get update

RUN sudo apt-get -y install newrelic-php5

RUN sudo NR_INSTALL_SILENT=1 newrelic-install install

RUN sed -i -e "s/REPLACE_WITH_REAL_KEY/94fca91fdcafed13b0918b672363029165fcNRAL/" \
        -e "s/newrelic.appname[[:space:]]=[[:space:]].*/newrelic.appname=\"e-Estado\"/" \
        $(php -r "echo(PHP_CONFIG_FILE_SCAN_DIR);")/newrelic.ini

WORKDIR /var/www

COPY ["composer.json", "composer.lock*", "./"]

RUN composer install

COPY . .

COPY ./docker/nginx/nginx.conf /etc/nginx/sites-enabled/default
COPY ./docker/entrypoint.sh /app/entrypoint.sh
COPY ./docker/php/php.ini "$PHP_INI_DIR/php.ini"
COPY ./docker/php-fpm.d/zz-overrides.conf "/usr/local/etc/php-fpm.d/zz-overrides.conf"

RUN chown -R www-data:www-data /var/www/uploads
RUN chmod -R 774 /var/www/uploads

EXPOSE 80

RUN chmod +x /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]
