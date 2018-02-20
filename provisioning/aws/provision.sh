#!/bin/bash

DOMAIN="${domain}"
APP_NAME="${app_name}"

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
fi

echo "Creating wordpress app"
dokku apps:create $APP_NAME
dokku domains:enable $APP_NAME