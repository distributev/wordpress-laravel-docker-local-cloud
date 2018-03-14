FROM wordpress:4.9.4-php7.2-apache

COPY .docker/*.sh /opt/
RUN apt-get update \
  && apt-get install -y dos2unix \
  && chmod +x /opt/*.sh \
  && dos2unix /opt/*.sh \
  && /opt/composer.sh \
  && /opt/wpcli.sh \
  && /opt/nodejs-yarn.sh \
  && /opt/laravel.sh \
  && /opt/utils.sh

RUN apt-get update \
  && apt-get install -y libcap2-bin \
  && setcap 'cap_net_bind_service=+eip' /usr/sbin/apache2 #allow apache to run on priviliged port (80)  


ENTRYPOINT ["docker-php-entrypoint"]

ENV APP_PATH /tmp/app
ENV BEDROCK_PATH $APP_PATH/bedrock
ENV SAGE_PATH $BEDROCK_PATH/web/app/themes/sage
ENV LARAVEL_PATH $APP_PATH/laravel

ENV LOCAL_BEDROCK_PATH bedrock
ENV LOCAL_SAGE_PATH $LOCAL_BEDROCK_PATH/web/app/themes/sage
ENV LOCAL_LARAVEL_PATH laravel

RUN mkdir -p $APP_PATH \
  mkdir -p $SAGE_PATH/dist \
  mkdir -p $LARAVEL_PATH \
  && chown -R www-data:www-data /var/www /tmp/app && chmod g+s .


USER www-data

WORKDIR $LARAVEL_PATH
COPY --chown=www-data:www-data $LOCAL_LARAVEL_PATH/composer.lock $LOCAL_LARAVEL_PATH/composer.json ./
COPY --chown=www-data:www-data $LOCAL_LARAVEL_PATH/database ./database
RUN composer install --no-dev --no-scripts
COPY --chown=www-data:www-data $LOCAL_LARAVEL_PATH/yarn.lock $LOCAL_LARAVEL_PATH/package.json ./
RUN yarn

WORKDIR $SAGE_PATH
COPY --chown=www-data:www-data $LOCAL_SAGE_PATH/composer.lock $LOCAL_SAGE_PATH/composer.json ./
RUN composer install --no-dev
COPY --chown=www-data:www-data $LOCAL_SAGE_PATH/yarn.lock $LOCAL_SAGE_PATH/package.json ./
RUN yarn

WORKDIR $BEDROCK_PATH
COPY --chown=www-data:www-data $LOCAL_BEDROCK_PATH/composer.lock $LOCAL_BEDROCK_PATH/composer.json ./
RUN composer install --no-dev


WORKDIR $APP_PATH
COPY  --chown=www-data:www-data . $APP_PATH

WORKDIR $SAGE_PATH
RUN yarn run build:production

WORKDIR $LARAVEL_PATH
RUN composer install --no-dev --optimize-autoloader \
  && npm run production


WORKDIR /var/www/html

EXPOSE 8080
COPY .docker/apache-sites.conf /etc/apache2/sites-available/000-default.conf

COPY .docker/wordpress.sh /opt/
USER root
RUN sed -i 's/^<VirtualHost \*:[0-9]*>$/<VirtualHost *:80>/g' /etc/apache2/sites-available/000-default.conf \
  && chmod +x /opt/wordpress.sh
USER www-data

# CMD ["apache2-foreground"]
CMD mv $APP_PATH/* /var/www/html && /opt/wordpress.sh /var/www/html/bedrock && exec apache2-foreground