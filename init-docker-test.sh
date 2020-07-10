#!/bin/bash
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

cd $SCRIPTPATH
docker-compose up -d
sleep 5
docker exec teste-docker-compose_teste-postgres-compose_1 psql -U postgres -c "CREATE DATABASE dvdrental;"
docker cp db-data/dvdrental.tar teste-docker-compose_teste-postgres-compose_1:/var/lib/postgresql/data
docker exec teste-docker-compose_teste-postgres-compose_1 pg_restore -U postgres -d dvdrental /var/lib/postgresql/data/dvdrental.tar
