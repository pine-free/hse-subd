#!/bin/bash
set -e

echo "Running migrations on database: $POSTGRES_DB as $POSTGRES_USER"
export PGPASSWD="$POSTGRES_PASSWORD"


shopt -s nullglob
MIGRATIONS_PATH=/docker-entrypoint-initdb.d/migrations/*.sql
if [[ -z $MIGRATIONS_PATH ]]
then
  echo "[v] No migrations detected, exiting"
  exit 0
fi

for file in $MIGRATIONS_PATH; do
  echo "> Applying $file"
  psql -v ON_ERROR_STOP=0 -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f $file;
done

echo "[v] Migrations complete"
