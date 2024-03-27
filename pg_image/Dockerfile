FROM debian:latest AS data

RUN DEBIAN_FRONTEND=noninteractive apt update && apt install git -y

RUN git clone https://github.com/jOOQ/sakila.git /sakila

FROM postgres:latest AS sakila_pg

COPY --from=data /sakila/postgres-sakila-db/postgres-sakila-schema.sql /docker-entrypoint-initdb.d/1-schema.sql
COPY --from=data /sakila/postgres-sakila-db/postgres-sakila-insert-data-using-copy.sql /docker-entrypoint-initdb.d/2-insert-data-using-copy.sql
#USER postgres
ENV POSTGRES_PASSWORD=mysecretpassword
ADD pg_install.sh .
RUN ./pg_install.sh
#RUN docker-entrypoint.sh

