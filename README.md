# agent

This project sets up a development environment for a Laravel application with Vue and Vite.

Use the provided `docker-compose` configuration to start all services. When the containers come up, composer dependencies will automatically be installed if missing, Vite will run in development mode with hot reloading, and `php artisan serve` will be started.

To start the environment:

```bash
make up
```

Access the application via:

- Laravel development server: http://localhost:8000
- Vite dev server for hot module replacement: http://localhost:5173
- Apache proxy: http://localhost:8123

