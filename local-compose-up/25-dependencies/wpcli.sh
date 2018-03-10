#!/bin/bash

# remove wordpress source code left by base image && install wordpress cli
# https://github.com/KaiHofstetter/docker-wordpress-cli/blob/master/Dockerfile
rm -rf /usr/src/wordpress
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp