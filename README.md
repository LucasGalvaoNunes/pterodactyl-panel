
# Pterodactyl Panel - Imagem Umbrel

Esta é uma imagem Docker customizada do painel [Pterodactyl](https://pterodactyl.io), criada para uso em ambientes como o [UmbrelOS](https://umbrel.com), com tudo pré-configurado para facilitar a instalação.

---

## 📦 Sobre a imagem

Esta imagem inclui:

- PHP 8.2 (base Alpine)
- Todas as dependências Laravel e PHP necessárias
- Clonagem automática do repositório `pterodactyl/panel`
- Instalação via Composer
- Geração automática do `.env`
- Execução do `php artisan key:generate`
- Servidor embutido via `php artisan serve`

---

## 🚀 Como usar

### Teste local

```bash
docker run -p 8989:80 --rm ghcr.io/lucasgalvaonunes/pterodactyl-panel:umbrel
```

Acesse: [http://localhost:8989](http://localhost:8989)

> O painel ainda precisa de um banco de dados MariaDB e Redis configurados separadamente.

---

## 🧱 Uso com `docker-compose`

Exemplo mínimo:

```yaml
services:
  panel:
    image: ghcr.io/lucasgalvaonunes/pterodactyl-panel:umbrel
    ports:
      - "8989:80"
    environment:
      APP_URL: http://localhost:8989
      DB_HOST: db
      DB_PORT: 3306
      DB_DATABASE: pterodactyl
      DB_USERNAME: pterodactyl
      DB_PASSWORD: secret
      CACHE_DRIVER: redis
      SESSION_DRIVER: redis
      QUEUE_CONNECTION: redis
      REDIS_HOST: redis
    volumes:
      - ./panel:/var/www/html
```

---

## 🛠 Repositório base

Esta imagem é baseada no repositório oficial do Pterodactyl:

- https://github.com/pterodactyl/panel

---

## 🤝 Contribuição

Aberta para contribuições. Se quiser enviar melhorias, fique à vontade para abrir PRs ou forks.

---

## 🐳 Autor

**Lucas Galvão**  
Imagem hospedada em:  
[ghcr.io/lucasgalvaonunes/pterodactyl-panel:umbrel](https://github.com/users/lucasgalvaonunes/packages/container/package/pterodactyl-panel)
