#!/bin/bash
set -ax

LARAVEL_PATH=$1

echo "Installing Laravel..."
composer create-project --prefer-dist laravel/laravel $LARAVEL_PATH
yarn --cwd=$LARAVEL_PATH
npm --prefix $LARAVEL_PATH run development
