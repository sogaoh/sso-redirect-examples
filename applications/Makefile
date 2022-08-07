.PHONY:

help:
	cat Makefile


IMG_TAG := latest
NO_DEV_OPT := --no-dev
BLDARG_NODEV_OPT := --build-arg NO_DEV_OPT=$(NO_DEV_OPT)
#BLDARG_NODEV_OPT=--build-arg NO_DEV_OPT=
AWS_ACCOUNT_ID :=
AWS_REGION := ap-northeast-1


# build
build: bd-web bd-cln
bd-web:
	docker build --no-cache -t auth-client/nginx-proxy:$(IMG_TAG) -f ./ship/docker/nginx-node/Dockerfile .
bd-cln:
	docker build --no-cache -t auth-client/laravel-app:$(IMG_TAG) -f ./ship/docker/php/Dockerfile . $(BLDARG_NODEV_OPT)

# tag
tag: tag-web tag-cln
tag-web:
	docker tag auth-client/nginx-proxy:$(IMG_TAG) "$(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/auth-client/nginx-proxy:$(IMG_TAG)"
tag-cln:
	docker tag auth-client/laravel-app:$(IMG_TAG) "$(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/auth-client/laravel-app:$(IMG_TAG)"

# push
push: push-web push-cln
push-web:
	docker push "$(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/auth-client/nginx-proxy:$(IMG_TAG)"
push-cln:
	docker push "$(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/auth-client/laravel-app:$(IMG_TAG)"


# run
run-web:
	docker run -it $$(docker images | grep auth-client/nginx-proxy | grep $(IMG_TAG) | awk '{print $$3}') ash
run-cln:
	docker run -it $$(docker images | grep auth-client/laravel-app | grep $(IMG_TAG) | awk '{print $$3}') bash

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

# logs
log-w:
	docker-compose logs -f web
log-c:
	docker-compose logs -f client
