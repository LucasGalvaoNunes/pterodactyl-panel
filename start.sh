#!/bin/bash

if [ ! -f /var/www/panel/.env ]; then
  echo "⚠️  Arquivo .env não encontrado, criando a partir de .env.example..."
  cp /var/www/panel/.env.example /var/www/panel/.env
else
  echo "✅ .env encontrado, iniciando aplicação."
fi

php-fpm -D
nginx -g "daemon off;"
