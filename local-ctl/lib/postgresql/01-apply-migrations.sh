#!/bin/bash
set -e

echo "Running migrations on database: $POSTGRES_DB as $POSTGRES_USER"
export PGPASSWD = "$POSTGRES_PASSWORD"

for file in /docker-entrypoint-initdb.d/migrations/*.sql; do
  echo "> Applying $file"
  psql -v ON_ERROR_STOP=0 -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f $file;
done

echo "[v] Migrations complete"
