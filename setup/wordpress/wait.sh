#!/bin/sh

#This init script will Compile assets when file changes are made, start Browsersync session

set -e

while ! nc -z wordpress 80; do
  echo "Waiting for wordpress service to start..."
  sleep 2
done

cd web/app/themes/sage && exec "$@"
