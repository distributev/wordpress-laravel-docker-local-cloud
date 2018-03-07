#This init script will generate new bedrock project and initialize wordpress
#!/bin/bash
set -ax

BEDROCK_PATH=${BEDROCK_PATH:-"bedrock"}
SAGE_PATH="$BEDROCK_PATH/web/app/themes/sage"
LARAVEL_PATH=${LARAVEL_PATH:-"laravel"}
APP_DOMAIN=${APP_DOMAIN:-"app.devel"}


chown -R www-data:www-data . && chmod g+s .

gosu www-data /opt/bedrock.sh $BEDROCK_PATH
gosu www-data /opt/sage.sh $SAGE_PATH $APP_DOMAIN
gosu www-data /opt/wordpress.sh $BEDROCK_PATH
gosu www-data /opt/laravel.sh $LARAVEL_PATH

for file in .dockerignore Dockerfile Dockerfile.dev docker-compose.yml 00-apache/apache-sites.conf 05-wordpress/wordpress.sh; 
do 
  cp "/tmp/setup/$file" .; 
done
chmod -R 777 .

set +x
echo "\n"
echo "****************************"
echo "EVERYTHING IS UP AND RUNNING"
echo "****************************"
echo "Wordpress app is accessible at this URL - ${WP_HOME}"
echo "Wordpress admin is accessible at this URL - ${WP_HOME}/wp/wp-admin/index.php"
echo "Laravel app is accessible at this URL - ${WP_HOME}/lara"
echo "Adminer app is accessible at this URL - http://127.0.0.1:9000\n"
