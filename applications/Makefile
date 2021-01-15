.PHONY:

help:
	cat Makefile


WEB_TAG := latest
CLN_TAG := latest
BLDARG_NODEV_OPT := --build-arg=NO_DEV_OPT=--no-dev
#BLDARG_NODEV_OPT=--build-arg=NO_DEV_OPT=
AWS_ACCOUNT_ID :=
AWS_REGION := ap-northeast-1


# build
build: bd-web bd-cln
bd-web:
	docker build --no-cache -t auth-client/nginx-proxy:$(WEB_TAG) -f ./ship/docker/nginx-node/Dockerfile .
	#docker build -t auth-client/nginx-proxy:$(WEB_TAG) -f ./ship/docker/nginx-node/Dockerfile .
bd-cln:
	docker build --no-cache -t auth-client/laravel-app:$(CLN_TAG) -f ./ship/docker/php/Dockerfile . $(BLDARG_NODEV_OPT)
	#docker build -t auth-client/laravel-app:$(CLN_TAG) -f ./ship/docker/php/Dockerfile . $(BLDARG_NODEV_OPT)

# tag
tag: tag-web tag-cln
tag-web:
	docker tag auth-client/nginx-proxy:$(WEB_TAG) "$(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/auth-client/nginx-proxy:$(WEB_TAG)"
tag-cln:
	docker tag auth-client/laravel-app:$(CLN_TAG) "$(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/auth-client/laravel-app:$(CLN_TAG)"

# push
push: push-web push-cln
push-web:
	docker push "$(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/auth-client/nginx-proxy:$(WEB_TAG)"
push-cln:
	docker push "$(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/auth-client/laravel-app:$(CLN_TAG)"


# run
run-web:
	docker run -it auth-client/proxy-nginx:$(WEB_TAG) ash
run-cln:
	docker run -it auth-client/laravel-app:$(CLN_TAG) bash

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

# logs
log-w:
	docker-compose logs -f web
log-c:
	docker-compose logs -f client
