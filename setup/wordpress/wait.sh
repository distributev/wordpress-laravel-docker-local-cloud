#!/bin/bash

#This init script will Compile assets when file changes are made, start Browsersync session

set -e

while ! nc -z wordpress $WP_PORT; do
  echo "Waiting for wordpress service to start..."
  sleep 5
done

exec "$@"
