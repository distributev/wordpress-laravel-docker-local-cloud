#!/bin/bash

#This init script will Compile assets when file changes are made, start Browsersync session

set -e

while ! nc -z 127.0.0.1 $APACHE_PORT; do
  echo "Waiting for project installation..."
  sleep 5
done

exec "$@"
