#!/bin/bash
set -ax

SAGE_PATH=$1

echo "Installing Sage9 theme..."
composer create-project roots/sage $SAGE_PATH dev-master
yarn --cwd=$SAGE_PATH #install npm dependencies
yarn --cwd=$SAGE_PATH run build #compile assets
