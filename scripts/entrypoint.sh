#!/bin/bash
set -e

# Function to run all php artisan commands
migrate_and_optimize() {

    # Run database migrations only if needed
    if [ "$MAKE_MIGRATIONS" = "false" ]; then
        echo "Skipping migrations..."
        return
    else
        echo "Running migrations..."
        php artisan migrate --force || echo "Migrations are already up-to-date."
    fi 

  # Seed the database if SEED_DATA is set to "true"
  if [ "$SEED_DATA" = "true" ]; then
    echo "Freshing the database"
    php artisan migrate:fresh || echo "Freshing the database"
    echo "Seeding the database..."
    php artisan db:seed --force || echo "Seeding failed, but continuing..."
  fi

  # Run any additional setup commands (e.g., cache clearing)
  php artisan optimize:clear
  php artisan config:cache
  php artisan event:cache
  php artisan route:cache
  php artisan view:cache

}
# export APP_DEBUG=false
# Run artisan commands in the background
migrate_and_optimize &

# Start PHP-FPM or any other command passed to the script
exec "$@"