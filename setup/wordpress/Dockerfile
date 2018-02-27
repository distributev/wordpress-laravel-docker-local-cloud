FROM wordpress:4.9.4-php7.2-apache

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (print hash_file('SHA384', 'composer-setup.php') ===  file_get_contents('https://composer.github.io/installer.sig')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

# install wordpress cli
# https://github.com/KaiHofstetter/docker-wordpress-cli/blob/master/Dockerfile
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN apt-get update; \
  apt-get install -y zip unzip libpng-dev libcap2-bin

RUN setcap 'cap_net_bind_service=+eip' /usr/sbin/apache2 #allow apache to run on priviliged port (80)  

ENV NODE_VERSION 8.9.4
RUN ARCH= && dpkgArch="$(dpkg --print-architecture)" \
  && case "${dpkgArch##*-}" in \
    amd64) ARCH='x64';; \
    ppc64el) ARCH='ppc64le';; \
    s390x) ARCH='s390x';; \
    arm64) ARCH='arm64';; \
    armhf) ARCH='armv7l';; \
    i386) ARCH='x86';; \
    *) echo "unsupported architecture"; exit 1 ;; \
  esac \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
  && curl -SLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt" \
  && grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
  && rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
  && npm install -g webpack@3.10.0

ENV YARN_VERSION 1.3.2
RUN set -ex \
  && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
  && mkdir -p /opt/yarn \
  && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/yarn --strip-components=1 \
  && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg \
  && rm yarn-v$YARN_VERSION.tar.gz

ENTRYPOINT ["docker-php-entrypoint"]

ENV APP_PATH /var/www/wordpress
ENV BEDROCK_PATH $APP_PATH/bedrock
ENV SAGE_PATH $BEDROCK_PATH/web/app/themes/sage
ENV LARAVEL_PATH $APP_PATH/laravel

ENV LOCAL_BEDROCK_PATH bedrock
ENV LOCAL_SAGE_PATH $LOCAL_BEDROCK_PATH/web/app/themes/sage
ENV LOCAL_LARAVEL_PATH laravel

RUN mkdir -p $APP_PATH \
  mkdir -p $SAGE_PATH/dist \
  mkdir -p $LARAVEL_PATH \
  && chown -R www-data:www-data /var/www && chmod g+s .


USER www-data

WORKDIR $LARAVEL_PATH
ADD $LOCAL_LARAVEL_PATH/composer.lock $LOCAL_LARAVEL_PATH/composer.json ./
ADD $LOCAL_LARAVEL_PATH/database ./database
RUN composer install --no-dev --no-scripts
ADD $LOCAL_LARAVEL_PATH/yarn.lock $LOCAL_LARAVEL_PATH/package.json ./
RUN yarn

WORKDIR $SAGE_PATH
ADD $LOCAL_SAGE_PATH/composer.lock $LOCAL_SAGE_PATH/composer.json ./
RUN composer install --no-dev
ADD $LOCAL_SAGE_PATH/yarn.lock $LOCAL_SAGE_PATH/package.json ./
RUN yarn

WORKDIR $BEDROCK_PATH
ADD $LOCAL_BEDROCK_PATH/composer.lock $LOCAL_BEDROCK_PATH/composer.json ./
RUN composer install --no-dev


WORKDIR $APP_PATH
COPY  --chown=www-data:www-data . $APP_PATH

WORKDIR $SAGE_PATH
RUN yarn run build:production

WORKDIR $LARAVEL_PATH
RUN composer install --no-dev --optimize-autoloader \
  && npm run production


WORKDIR $APP_PATH

EXPOSE 8080
COPY apache-sites.conf /etc/apache2/sites-available/000-default.conf

COPY wp_init.sh /opt/
USER root
RUN chmod +x /opt/wp_init.sh
USER www-data

# CMD ["apache2-foreground"]
CMD /opt/wp_init.sh && exec apache2-foreground