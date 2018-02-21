#This init script will generate new bedrock project and initialize wordpress
#!/bin/bash
set -ax

WP_INIT=${WP_INIT:-"no"}

if [ ${WP_INIT} = "yes" ]; then
  # install bedrock & set permissions
  echo "Installing bedrock..."
  chown -R www-data:www-data . && chmod g+s .
  gosu www-data composer create-project roots/bedrock .


  echo "Installing Sage9 theme..."
  gosu www-data composer create-project roots/sage web/app/themes/sage dev-master
  yarn --cwd=web/app/themes/sage #install npm dependencies
  yarn --cwd=web/app/themes/sage run build #compile assets
  
  echo "Installing wordpress..."
  gosu www-data wp core install \
    --title=${SITE_TITLE} \
    --admin_user=${ADMIN_USER} \
    --admin_password=${ADMIN_PASS} \
    --admin_email=${ADMIN_EMAIL} \
    --url=${WP_HOME} \
    --skip-email
  gosu www-data wp theme activate sage/resources #activate sage theme


  #Install Laravel
  gosu www-data composer create-project --prefer-dist laravel/laravel web/app/lara
  yarn --cwd=web/app/lara
  npm --prefix web/app/lara run development

  cp -r /tmp/wordpress/. ${APP_PATH}/ #Copy Dockerfile and .dockerignore to root project
  chmod -R 777 .
fi
