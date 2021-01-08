.PHONY:

help:
	cat Makefile

BLDARG_NODEV_OPT := --build-arg=NO_DEV_OPT=--no-dev
#BLDARG_NODEV_OPT=--build-arg=NO_DEV_OPT=

# build
build: bd-web bd-cln
bd-web:
	docker build --no-cache -t sso-redirect-examples/web:develop -f ./ship/docker/nginx-node/Dockerfile .
bd-cln:
	docker build --no-cache -t sso-redirect-examples/client:develop -f ./ship/docker/php/Dockerfile . $(BLDARG_NODEV_OPT)

# run
run-web:
	docker run -it sso-redirect-examples/web:develop ash
run-cln:
	docker run -it sso-redirect-examples/client:develop bash

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
