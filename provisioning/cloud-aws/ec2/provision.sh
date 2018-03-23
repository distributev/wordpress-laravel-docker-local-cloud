#!/bin/bash

DOMAIN="${domain}"
APP_NAME="${app_name}"
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




echo "Creating wordpress app"
dokku apps:create $APP_NAME
dokku domains:enable $APP_NAME
dokku domains:add $APP_NAME $APP_NAME.$DOMAIN
dokku proxy:ports-add $APP_NAME http:80:80
dokku proxy:ports-remove $APP_NAME http:80:5000
dokku mysql:link $DB_NAME $APP_NAME

#Variables related to Wordpress
dokku config:set --no-restart $APP_NAME SITE_TITLE=${site_title}
dokku config:set --no-restart $APP_NAME ADMIN_USER=${admin_user}
dokku config:set --no-restart $APP_NAME ADMIN_PASS=${admin_pass}
dokku config:set --no-restart $APP_NAME ADMIN_EMAIL=${admin_email}
dokku config:set --no-restart $APP_NAME WP_HOME=http://$APP_NAME.$DOMAIN
dokku config:set --no-restart $APP_NAME WP_SITEURL=http://$APP_NAME.$DOMAIN/wp
dokku config:set --no-restart $APP_NAME WP_ENV=production

#Variables related to Laravel
dokku config:set --no-restart $APP_NAME APP_URL=http://$APP_NAME.$DOMAIN/lara
dokku config:set --no-restart $APP_NAME DB_CONNECTION=mysql
#Laravel app key must be generate one time and stored carefully, sensitive data in database will be encrypted with it
LARAVEL_APP_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
echo $LARAVEL_APP_KEY >> /home/dokku/$APP_NAME_laravel_app_key #not working
dokku config:set --no-restart $APP_NAME APP_KEY=$LARAVEL_APP_KEY

cat > /home/dokku/connect-to-db.sh << EOF
#!/bin/bash
#Usage ./connect-to-db.sh appName typeDb
#appName: bedrock application name set in Dokku
#typeDb: which database you to connect, could be dokku-mysql or rds

APP_NAME=\$1
DB_TYPE=\$2
DB_NAME=${mysql_db_name}
DOKKU_MYSQL_PASSWORD=$(dokku mysql:info $DB_NAME --dsn | awk -F ':' '{print $3}' | awk -F '@' '{print $1}')

dokku config:set --no-restart $APP_NAME DB_NAME=\$DB_NAME #Wordpress
dokku config:set --no-restart $APP_NAME DB_DATABASE=\$DB_NAME #Laravel

case "\$DB_TYPE" in
  #List patterns for the conditions you want to meet
  "dokku-mysql") 
    #Variables that configures connection to dokku-mysql for both Wordpress and Laravel
    dokku config:set --no-restart $APP_NAME DB_USER=mysql #Wordpress
    dokku config:set --no-restart $APP_NAME DB_USERNAME=mysql #Laravel
    dokku config:set --no-restart $APP_NAME DB_PASSWORD=\$DOKKU_MYSQL_PASSWORD
    dokku config:set $APP_NAME DB_HOST=dokku-mysql-\$DB_NAME
  ;;
  "rds")
    #Variables that configures connection to rds for both Wordpress and Laravel
    dokku config:set --no-restart $APP_NAME DB_USER=${rds_mysql_user} #Wordpress
    dokku config:set --no-restart $APP_NAME DB_USERNAME=${rds_mysql_user} #Laravel
    dokku config:set --no-restart $APP_NAME DB_PASSWORD=${rds_mysql_password}
    dokku config:set $APP_NAME DB_HOST=${rds_host}
  ;;
  *) echo "Wrong database type";;
esac
EOF
chmod +x /home/dokku/connect-to-db.sh
if [ ${connect_to_rds} == "yes" ]
then
  docker run -d -p ${adminer_port}:8080 --name adminer adminer
  /home/dokku/connect-to-db.sh $APP_NAME "rds"
else
  echo "Installing MySQL Dokku plugin"
  dokku plugin:list | tail -n '+2' | awk '{print $1}' | grep -qe ^mysql$
  if [ $? -eq 0 ]
  then
      echo "MySQL plugin is already installed"
  else
      echo "Installing MySQL plugin..."
      dokku plugin:install https://github.com/dokku/dokku-mysql.git mysql
      MYSQL_IMAGE_VERSION="${mysql_version}" SERVICE_PASSWORD="${dokku_mysql_password}" dokku mysql:create $DB_NAME
  fi
  docker run -d -p ${adminer_port}:8080 --link dokku.mysql.$DB_NAME:db --name adminer adminer
  /home/dokku/connect-to-db.sh $APP_NAME "dokku-mysql"
fi

echo "Creating new user"
if [[ -n "${ec2_user}" ]]; then
  useradd ${ec2_user} -m -s /bin/bash
  usermod -aG sudo ${ec2_user}
  echo "${ec2_user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ahmed
  echo -e "${ec2_password}\n${ec2_password}\n" | sudo passwd ${ec2_user}
  sed -i 's/^PasswordAuthentication no$/PasswordAuthentication yes/g' /etc/ssh/sshd_config
  /usr/sbin/sshd -t || exit 1;
  systemctl reload sshd
  # rm -f /var/lib/cloud/instances/*/user-data.txt #remove this script from the server as it contains password
fi