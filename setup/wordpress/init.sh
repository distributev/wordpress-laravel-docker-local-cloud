#This init script will generate new bedrock project and initialize wordpress
#!/bin/bash
set -eax

WP_INIT=${WP_INIT:-"no"}
PATH_PROJECT="/var/www/html"

if [ ${WP_INIT} = "yes" ]; then
  # install bedrock & set permissions
  echo "Installing bedrock..."
  chown -R www-data:www-data . && chmod g+s .
  gosu www-data composer create-project roots/bedrock . && chmod -R 755 .

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

fi
