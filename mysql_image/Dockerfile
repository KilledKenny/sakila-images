FROM debian:latest AS data

RUN DEBIAN_FRONTEND=noninteractive apt update && apt install git -y

RUN git clone https://github.com/jOOQ/sakila.git /sakila

FROM mysql:8.0-debian AS sakila_mysql

RUN DEBIAN_FRONTEND=noninteractive apt update && apt install -y python3 sudo

ENV MYSQL_ROOT_PASSWORD=my-secret-pw
COPY --from=data /sakila/mysql-sakila-db/mysql-sakila-schema.sql /docker-entrypoint-initdb.d/1-mysql-sakila-schema.sql
COPY --from=data /sakila/mysql-sakila-db/mysql-sakila-insert-data.sql /docker-entrypoint-initdb.d/2-mysql-sakila-insert-data.sql

ADD mysql_install.sh .
RUN ./mysql_install.sh