#!/bin/bash

. /usr/local/bin/docker-entrypoint.sh

set -- mariadbd

# Based on orignial PG entrypoint
mysql_note "Entrypoint script for MariaDB Server ${MARIADB_VERSION} started."

mysql_check_config "$@"
# Load various environment variables
docker_setup_env "$@"
docker_create_db_directories

# If container is started as root user, restart as dedicated mysql user
if [ "$(id -u)" = "0" ]; then
    mysql_note "Switching to dedicated user 'mysql'"
    exec gosu mysql "${BASH_SOURCE[0]}" "$@"
fi

# there's no database, so it needs to be initialized
if [ -z "$DATABASE_ALREADY_EXISTS" ]; then
    docker_verify_minimum_env

    docker_mariadb_init "$@"
# MDEV-27636 mariadb_upgrade --check-if-upgrade-is-needed cannot be run offline
#elif mariadb-upgrade --check-if-upgrade-is-needed; then
elif _check_if_upgrade_is_needed; then
    docker_mariadb_upgrade "$@"
fi