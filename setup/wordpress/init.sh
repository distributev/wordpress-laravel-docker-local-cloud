#This init script will generate new bedrock project and initialize wordpress
#!/bin/bash
set -ax

WP_INIT=${WP_INIT:-"no"}
BEDROCK_PATH=${BEDROCK_PATH:-"bedrock"}
SAGE_PATH="$BEDROCK_PATH/web/app/themes/sage"
LARAVEL_PATH=${LARAVEL_PATH:-"laravel"}

if [ ${WP_INIT} = "yes" ]; then
  # install bedrock
  echo "Installing bedrock..."
  chown -R www-data:www-data . && chmod g+s .
  gosu www-data composer create-project roots/bedrock $BEDROCK_PATH


  echo "Installing Sage9 theme..."
  gosu www-data composer create-project roots/sage $SAGE_PATH dev-master
  yarn --cwd=$SAGE_PATH #install npm dependencies
  yarn --cwd=$SAGE_PATH run build #compile assets
  
  echo "Installing wordpress..."
  gosu www-data /opt/wp_init.sh


  #Install Laravel
  gosu www-data composer create-project --prefer-dist laravel/laravel $LARAVEL_PATH
  yarn --cwd=$LARAVEL_PATH
  npm --prefix $LARAVEL_PATH run development

  cp -r /tmp/wordpress/. . #Copy Dockerfile and .dockerignore to root project
  chmod -R 777 .
fi
