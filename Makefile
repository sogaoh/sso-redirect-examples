.PHONY:

help:
	cat Makefile

# build
build: bd-web bd-cl
bd-web:
	docker build -t sso-redirect-examples/web:develop -f ./deploy/docker/auth-client/nginx-node/Dockerfile .
bd-cl:
	docker build -t sso-redirect-examples/client:develop -f ./deploy/docker/auth-client/php/Dockerfile .

# run
run-web:
	docker run -it sso-redirect-examples/web:develop ash
run-cl:
	docker run -it sso-redirect-examples/client:develop bash

# up/down
up:
	docker-compose up -d
down:
	docker-compose down --remove-orphans
restart:
	@make down
	@make up

# exec
exec-web:
	docker-compose exec web ash
exec-cl:
	docker-compose exec client bash
