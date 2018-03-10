#!/bin/bash

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (print hash_file('SHA384', 'composer-setup.php') ===  file_get_contents('https://composer.github.io/installer.sig')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"