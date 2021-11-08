#!/bin/bash
if [ -e config/.env ]
  then
      echo "Le fichier .env existe"
      source /app/config/.env
      # Wait until Postgres is ready
      while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
      do
        echo "$(date) - waiting for database to start"
        sleep 2
      done

      # Create, migrate, and seed database if it doesn't exist.
      if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
        echo "Database $PGDATABASE does not exist. Creating..."
        mix ecto.create
        mix ecto.migrate
        echo "Database $PGDATABASE created."
      fi

      exec mix phx.server

      while [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]
      do
        echo "Database $PGDATABASE does not exist. !!!!!!!!!!!!!!!!!!!"
        sleep 2
      done
  else
      echo "Le fichier .env n'existe pas, Container helloworld_phoenix is stopped !"
fi