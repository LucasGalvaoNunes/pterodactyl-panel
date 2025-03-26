FROM php:8.1-fpm-alpine

RUN apk add --no-cache \
    bash \
    git \
    curl \
    zip \
    unzip \
    mariadb-client \
    nginx \
    supervisor \
    nodejs \
    npm \
    openssl \
  && docker-php-ext-install pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN git clone https://github.com/pterodactyl/panel.git /var/www/html
WORKDIR /var/www/html

RUN composer install --no-interaction --prefer-dist --optimize-autoloader

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage /var/www/html/bootstrap/cache

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=80"]
