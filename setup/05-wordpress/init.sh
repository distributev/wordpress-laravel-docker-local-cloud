#This init script will generate new bedrock project and initialize wordpress
#!/bin/bash
set -ax

WP_INIT=${WP_INIT:-"no"}
BEDROCK_PATH=${BEDROCK_PATH:-"bedrock"}
SAGE_PATH="$BEDROCK_PATH/web/app/themes/sage"
LARAVEL_PATH=${LARAVEL_PATH:-"laravel"}

chown -R www-data:www-data . && chmod g+s .

if [ ${WP_INIT} = "yes" ]; then

  gosu www-data /opt/bedrock.sh $BEDROCK_PATH
  gosu www-data /opt/sage.sh $SAGE_PATH
  gosu www-data /opt/wordpress.sh $BEDROCK_PATH
  gosu www-data /opt/laravel.sh $LARAVEL_PATH


  for file in .dockerignore Dockerfile Dockerfile.dev docker-compose.yml 00-apache/apache-sites.conf 05-wordpress/wordpress.sh; 
  do 
    cp "/tmp/setup/$file" .; 
  done
  chmod -R 777 .
fi
