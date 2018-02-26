#!/bin/bash

(cd ${BEDROCK_PATH} && wp core install \
  --title=${SITE_TITLE} \
  --admin_user=${ADMIN_USER} \
  --admin_password=${ADMIN_PASS} \
  --admin_email=${ADMIN_EMAIL} \
  --url=${WP_HOME} \
  --skip-email && wp theme activate sage/resources)