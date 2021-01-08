.PHONY:

help:
	cat Makefile

# environments
chmod:
	docker-compose exec client chmod -R a+w storage
	docker-compose exec client chmod -R a+w bootstrap/cache
local:
	\cp -p .env.local .env
	@make up
	@make chmod
re-bld:
	docker-compose build --no-cache --force-rm

# up/down
up:
	docker-compose up -d
down:
	docker-compose down --remove-orphans
prune:
	docker system prune --volumes
restart:
	@make down
	@make up

# exec
web:
	docker-compose exec web ash
cln:
	docker-compose exec client bash
