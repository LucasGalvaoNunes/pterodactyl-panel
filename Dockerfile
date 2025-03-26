FROM php:8.2-fpm-alpine

RUN apk add --no-cache \
    bash git curl zip unzip mariadb-client nginx supervisor nodejs npm openssl \
    libpng-dev libjpeg-turbo-dev libwebp-dev freetype-dev oniguruma-dev libzip-dev \
  && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        --with-webp \
  && docker-php-ext-install pdo pdo_mysql mbstring zip bcmath gd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN git clone https://github.com/pterodactyl/panel.git /var/www/html
WORKDIR /var/www/html

RUN mkdir -p storage/logs bootstrap/cache
RUN cp .env.example .env

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 storage bootstrap/cache

USER www-data
RUN composer install --no-interaction --prefer-dist --optimize-autoloader
RUN php artisan key:generate

USER root

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=80"]