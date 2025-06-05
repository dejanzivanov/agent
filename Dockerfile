FROM php:8.3-fpm-alpine as base
WORKDIR /var/www
RUN apk add --no-cache git curl libzip-dev unzip nodejs npm
RUN docker-php-ext-install pdo_mysql zip
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY laravel/ ./
RUN composer install --no-interaction --prefer-dist
RUN npm ci && npm run build && rm -rf node_modules
CMD ["php-fpm"]
