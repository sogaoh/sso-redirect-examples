.PHONY:

help:
	cat Makefile

# environments
chmod:
	docker-compose exec client chmod -R a=rwX storage
	docker-compose exec client chmod -R a=rwX bootstrap/cache
local:
	\cp -p .env.local .env
	@make up
	@make chmod

# up/down
build:
	docker-compose build --no-cache --force-rm
up:
	docker-compose up -d
down:
	docker-compose down --remove-orphans
restart:
	@make down
	@make up

# exec
web:
	docker-compose exec web ash
cl:
	docker-compose exec client bash
