#This init script will generate new bedrock project and initialize wordpress
#!/bin/bash
set -ax

WP_INIT=${WP_INIT:-"no"}
SAGE_THEME_NAME=${SAGE_THEME_NAME:-"sage"}

if [ ${WP_INIT} = "yes" ]; then
  # install bedrock & set permissions
  echo "Installing bedrock..."
  chown -R www-data:www-data . && chmod g+s .
  gosu www-data composer create-project roots/bedrock .

  if [ -n "$ADMIN_USER" ] && [ -n "$ADMIN_PASS" ] && [ -n "$ADMIN_EMAIL" ] && [ -n "$SITE_TITLE" ]; then
    sync # see: https://github.com/docker/docker/issues/9547

    echo "Installing wordpress..."
    gosu www-data wp core install \
      --title=${SITE_TITLE} \
      --admin_user=${ADMIN_USER} \
      --admin_password=${ADMIN_PASS} \
      --admin_email=${ADMIN_EMAIL} \
      --url=${WP_HOME} \
      --skip-email
  fi

  gosu www-data composer create-project roots/sage web/app/themes/${SAGE_THEME_NAME} dev-master
  yarn --cwd=web/app/themes/${SAGE_THEME_NAME}

  cd web/app/themes/${SAGE_THEME_NAME} && yarn run build

  cp -r /tmp/wordpress/. ${APP_PATH}/ #Copy Dockerfile and .dockerignore to root project
  chmod -R 777 .
fi
