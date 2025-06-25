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

.PHONY: build up stop down restart logs shell fclean
