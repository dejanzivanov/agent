#!/bin/sh
set -e

cd /var/www

if [ ! -d vendor ]; then
    composer install --no-interaction
fi

if [ ! -d node_modules ]; then
    npm install
fi

npm run dev -- --host --port 5173 &

php artisan serve --host=0.0.0.0 --port=8000

