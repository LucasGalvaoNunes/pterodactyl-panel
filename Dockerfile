FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
    curl zip unzip git nginx supervisor \
    libpng-dev libonig-dev libxml2-dev libzip-dev \
    libcurl4-openssl-dev libssl-dev \
    libpq-dev mariadb-client \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl bcmath curl

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

WORKDIR /var/www/panel

RUN git clone https://github.com/pterodactyl/panel.git . && \
    git checkout v1.11.4

RUN composer install --no-dev --optimize-autoloader && \
    yarn && yarn build:production && \
    mkdir -p /var/www/panel/storage/logs && \
    chown -R www-data:www-data /var/www/panel

COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]
