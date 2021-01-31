FROM mysql:8.0

COPY ./docker/mysql/my.cnf /etc/mysql/my.cnf

ARG TZ

RUN set -eux && \
    ln -sf  /usr/share/zoneinfo/${TZ} /etc/localtime && \
    chmod 644 /etc/mysql/my.cnf && \
    mkdir /var/lib/mysql-files && \
    mkdir /var/log/mysql && \
    chmod 0750 /var/log/mysql && \
    chmod 0775 /var/log && \
    chmod 0755 /var && \
    chown mysql:root /var/log/mysql
