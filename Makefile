git restore --source codex/rework-welcome.blade.php-with-vue-component Makefile
COMPOSE=docker compose

build:
	$(COMPOSE) build

up:
	$(COMPOSE) up -d

stop:
	$(COMPOSE) stop

down:
	$(COMPOSE) down

restart: down up

logs:
	$(COMPOSE) logs -f

shell:
	$(COMPOSE) exec app sh

force:
	$(COMPOSE) down -v
	$(COMPOSE) build --no-cache
	$(COMPOSE) up -d

fclean:
	$(COMPOSE) down -v
	docker ps -a --filter "name=agent_" -q | xargs -r docker rm -f
	docker volume ls --filter "name=agent_" -q | xargs -r docker volume rm
	docker network ls --filter "name=agent_" -q | xargs -r docker network rm

# BEGINNING OF THE ARTISAN COMMANDS

migrate:
	$(COMPOSE) exec app php artisan migrate

seed:
	$(COMPOSE) exec app php artisan db:seed

rollback:
	$(COMPOSE) exec app php artisan migrate:rollback

fresh:
	$(COMPOSE) exec app php artisan migrate:fresh

wipe:
	$(COMPOSE) exec app php artisan db:wipe

cache:
	$(COMPOSE) exec app php artisan cache:clear

optimize:
	$(COMPOSE) exec app php artisan optimize

queue:
	$(COMPOSE) exec app php artisan queue:work

serve:
	$(COMPOSE) exec app php artisan serve

# Dynamic (parameterized) commands

controller:
	$(COMPOSE) exec app php artisan make:controller $(name)

model:
	$(COMPOSE) exec app php artisan make:model $(name) -m

migration:
	$(COMPOSE) exec app php artisan make:migration $(name)

seeder:
	$(COMPOSE) exec app php artisan make:seeder $(name)

job:
	$(COMPOSE) exec app php artisan make:job $(name)

#END OF THE PHP ARTISAN COMMANDS

.PHONY: build up stop down restart logs shell force fclean \
	migrate seed rollback fresh wipe cache optimize queue serve \
	controller model migration seeder job
