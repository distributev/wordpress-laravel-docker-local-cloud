#!/bin/bash
set -ax

SAGE_PATH=$1
APP_DOMAIN=$2

if [ ! -d $SAGE_PATH ]; then

  echo "Installing Sage9 theme..."
  composer create-project roots/sage $SAGE_PATH dev-master
  yarn --cwd=$SAGE_PATH #install npm dependencies
  yarn --cwd=$SAGE_PATH run build #compile assets
  
fi

  cat > $SAGE_PATH/resources/assets/config-local.json << EOF
{
  "proxyUrl": "http://$APP_DOMAIN:3000"
}
EOF
