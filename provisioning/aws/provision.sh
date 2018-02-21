#!/bin/bash

DOMAIN="${domain}"
APP_NAME="${app_name}"
MYSQL_VERSION="${mysql_version}"
DB_NAME="${mysql_db_name}"


echo "Installing Dokku"
wget https://raw.githubusercontent.com/dokku/dokku/v0.11.3/bootstrap.sh;
DOKKU_TAG=${dokku_version} bash bootstrap.sh

echo "${key_dokku}" | dokku ssh-keys:add admin

hostname $DOMAIN
grep /etc/hosts -qe "^127.0.0.1 $DOMAIN$" || echo "127.0.0.1 $DOMAIN" | tee -a /etc/hosts
echo "$DOMAIN" > /etc/hostname
dokku domains:set-global $DOMAIN

echo "Killing dokku ui installer server"
DUKKU_INSTALLER_SERVER_PID=$(netstat -ntulp | grep "0.0.0.0:2000" | awk '{print $7}' | awk -F '/' '{printf $1}')
if [ -n "$DUKKU_INSTALLER_SERVER_PID" ]
then
  kill -9 $DUKKU_INSTALLER_SERVER_PID
fi


echo "Installing MySQL Dokku plugin"
dokku plugin:list | tail -n '+2' | awk '{print $1}' | grep -qe ^mysql$
if [ $? -eq 0 ]
then
    echo "MySQL plugin is already installed"
else
    echo "Installing MySQL plugin..."
    dokku plugin:install https://github.com/dokku/dokku-mysql.git mysql
    MYSQL_IMAGE_VERSION="$MYSQL_VERSION" dokku mysql:create $DB_NAME
fi

echo "Creating wordpress app"
dokku apps:create $APP_NAME
dokku domains:enable $APP_NAME
dokku domains:add $APP_NAME $APP_NAME.$DOMAIN
dokku proxy:ports-add $APP_NAME http:80:8080
dokku proxy:ports-remove $APP_NAME http:80:5000
dokku mysql:link $DB_NAME $APP_NAME
DB_PASSWORD=$(dokku mysql:info $DB_NAME --dsn | awk -F ':' '{print $3}' | awk -F '@' '{print $1}')
dokku config:set --no-restart wordpress DB_NAME=$DB_NAME
dokku config:set --no-restart wordpress DB_USER=mysql
dokku config:set --no-restart wordpress DB_PASSWORD=$DB_PASSWORD
dokku config:set --no-restart wordpress DB_HOST=dokku-mysql-$DB_NAME

dokku config:set --no-restart wordpress SITE_TITLE=${site_title}
dokku config:set --no-restart wordpress ADMIN_USER=${admin_user}
dokku config:set --no-restart wordpress ADMIN_PASS=${admin_pass}
dokku config:set --no-restart wordpress ADMIN_EMAIL=${admin_email}
dokku config:set --no-restart wordpress WP_HOME=http://$APP_NAME.$DOMAIN
dokku config:set --no-restart wordpress WP_SITEURL=http://$APP_NAME.$DOMAIN/wp

dokku config:set wordpress WP_ENV=production
