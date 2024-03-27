FROM debian:latest AS data

RUN DEBIAN_FRONTEND=noninteractive apt update && apt install git -y

RUN git clone https://github.com/jOOQ/sakila.git /sakila

FROM icr.io/db2_community/db2:latest AS sakila_db2

COPY --from=data /sakila/db2-sakila-db/db2-sakila-schema.sql /docker-entrypoint-initdb.d/1-schema.sql
COPY --from=data /sakila/db2-sakila-db/db2-sakila-insert-data.sql /docker-entrypoint-initdb.d/2-insert-data.sql
#USER postgres

ENV DB2INSTANCE=db2inst1
ENV DB2INST1_PASSWORD=password
ENV DBNAME=sakila
ENV HADR_ENABLED=false
ENV REPODB=false
ENV IS_OSXFS=false

ADD db2_install.sh .
RUN ./db2_install.sh
#RUN docker-entrypoint.sh

