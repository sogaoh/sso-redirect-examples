FROM node:14.2-alpine as node
LABEL maintainer="Hisashi SOGA <sogaoh@ant-in-giant.work>"

COPY ./auth-client /work

WORKDIR /work

RUN apk add --update \
    && npm install \
    && npm run prod


FROM nginx:1.18-alpine

SHELL ["/bin/ash", "-oeux", "pipefail", "-c"]

#ENV TZ=UTC
ENV TZ=Asia/Tokyo

RUN apk update && \
  apk add --update --no-cache --virtual=.build-dependencies g++

# node command
COPY --from=node /usr/local/bin /usr/local/bin
# npm command
COPY --from=node /usr/local/lib /usr/local/lib
# yarn command
COPY --from=node /opt /opt

# nginx config file
COPY ./ship/docker/nginx-node/ecs/default.conf /etc/nginx/conf.d/default.conf

# copy scripts
COPY --from=node /work/public /work/public/


WORKDIR /work
