FROM debian:latest AS data

RUN DEBIAN_FRONTEND=noninteractive apt update && apt install git -y

RUN git clone https://github.com/jOOQ/sakila.git /sakila

FROM mariadb:latest AS sakila_mariadb


ENV MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=1
COPY --from=data /sakila/mysql-sakila-db/mysql-sakila-schema.sql /docker-entrypoint-initdb.d/1-mysql-sakila-schema.sql
COPY --from=data /sakila/mysql-sakila-db/mysql-sakila-insert-data.sql /docker-entrypoint-initdb.d/2-mysql-sakila-insert-data.sql

ADD mariadb_install.sh .
RUN ./mariadb_install.sh
