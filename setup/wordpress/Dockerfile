FROM wordpress:4.9.4-php7.2-fpm

ENV APP_PATH /var/www/html

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (print hash_file('SHA384', 'composer-setup.php') ===  file_get_contents('https://composer.github.io/installer.sig')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"


#TO-Do: Install SAGE dependencies

ADD ./app/composer.json $APP_PATH/


WORKDIR $APP_PATH

# set folder permissions
RUN chown -R www-data:www-data /var/www .

ENTRYPOINT ["docker-php-entrypoint"]
ADD bedrock-apache.conf /etc/apache2/sites-available/000-default.conf
CMD ["apache2-foreground"]








