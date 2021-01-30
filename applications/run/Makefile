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
upb:
	docker-compose up -d --build
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
db:
	docker-compose exec db bash
redis:
	docker-compose exec redis ash

# log
log-w:
	docker-compose logs -f web
log-c:
	docker-compose logs -f client
log-d:
	docker-compose logs -f db
log-r:
	docker-compose logs -f redis
