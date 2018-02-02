# Scope of Project

Use Docker to provide a WordPress / Laravel environment which will be easy to use for local development and for deploying to the cloud (AWS)

* Local windows development environment (using Docker)
* Push to git ==> Get deployed automatically live in production (without having to manually FTP upload PHP files or anything like that)


# Tools Used

* Docker - https://www.docker.com
* Laradock - http://laradock.io
* Dokku - https://github.com/dokku/dokku
* Composer - https://getcomposer.org
* Laravel - https://laravel.com
* WordPress - https://wordpress.org
* Bedrock WordPress project boilerplate - https://github.com/roots/bedrock
* Sage9 WordPress starter theme - https://github.com/roots/sage
* Adminer - https://www.adminer.org
* The AWS Elastic Beanstalk Command Line Interface (EB CLI) - https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3.html

# Permalink structure

https://apps.domain.com  (WordPress should be available here - with the Sage 9 starter theme)<br>
https://apps.domain.com/wp-admin  (WordPress admin should be available here)<br>
https://apps.domain.com/lara-admin  (Laravel starter app should be available here)<br>

# How Testing Will Be Done

* Delete everything related with the wordpress-laravel-docker-local-cloud project from local computer (Windows)
* git clone the wordpress-laravel-docker-local-cloud project repository from github

Without any further / manual configuration WordPress, Laravel (/lara-admin) and Adminer should work fine when started both locally and in the AWS cloud (WordPress and Adminer should not require any additional installation everything should be correctly pre-installed and configured inside the docker containers). Adminer should be pre-configured to connect to the WordPress MySQL database.

## Testing Local (Windows) development environment (through Docker)

<strong>Laravel</strong> - Change the default "hello word" lara-admin entry point and refresh the browser's locally corresponding https://apps.company.com/lara-admin/ URL and then make sure the changed Laravel starter hello world version is coming  

<strong>WordPress</strong> - Modify Sage9's index.blade.php https://github.com/roots/sage/blob/master/resources/views/index.blade.php refresh the browser's locally corresponding https://apps.company.com URL and make sure the update version is coming 

## Testing Cloud (AWS) Production

Use laradock/aws/ (see below) AWS elasticbeanstalk command line to deploy all needed laradock docker containers images to AWS (don't do any manual step like don't do FTP or any similar manual upload - All initial AWS deploy should work automatically through the AWS elasticbeanstalk command line)

Once deployed to AWS ...

<strong>Laravel</strong> - change and then do <em>git push</em> to the default "hello world" Laravel started app (/lara-admin) entry point and then refresh the browser's AWS production corresponding https://apps.domain.com/lara-admin/ URL and make sure the changed Laravel hello worlld version is served (dokku / heroku-build-pack should deploy / refresh the new PHP code automatically - without having to manually upload any PHP file)

<strong>WordPress</strong> -  change and then do <em>git push</em> to Sage9's index.blade.php https://github.com/roots/sage/blob/master/resources/views/index.blade.php and then refresh the browser's AWS production corresponding https://apps.domain.com URL and make sure the updated page is coming

<hr>

# Steps to Implement the Above Requirements

<strong>Step 1</strong> - Have http://laradock.io/getting-started/#installation pre-requisites in-place

<strong>Step 2</strong> - used Laradock to install a LEMP stack

get the standard laradock images for NGINX, MySQL, Adminer and AWS (laradock/aws/ is required to get AWS elasticbeanstalk which adds support to automatically deploy to AWS using command line)

Get and then alter (only) the PHP laradock image to build from a dokku compatible Linux container (i.e. Ubuntu) - by default most of laradock.io images build from alpine linux (which is not supported by dokku)

On the modified PHP image install / make available Composer tool (for dependency management in PHP)

<strong>Step 3</strong> - On the above PHP/Composer image install roots.io's Bedrock WordPress project boilerplate

https://roots.io/bedrock/

which allows managing the WordPress install and plugins using Composer

<strong>Step 4</strong> - Using Composer install Laravel inside the Bedrock's /web/app/lara-admin folder (lara-admin parent's folder should be Bedrock's /web/app/ folde) - see Bedrock folder structure for more details - https://roots.io/bedrock/

<strong>Step 5</strong> - Install roots.io's Sage 9 WordPress Theme on the same PHP/Composer image

https://github.com/roots/sage

<strong>Step 6</strong> - Install dokku on the PHP image (remember the PHP image was altered to support dokku) 

http://dokku.viewdocs.io/dokku/getting-started/installation/

<strong>Step 7</strong> - Configure whatever is required to get the required permalink structure working fine

https://apps.domain.com  (WordPress should be available here - Sage 9 theme)<br>
https://apps.domain.com/wp-admin  (WordPress admin should be available here)<br> 
https://apps.domain.com/lara-admin  (Laravel "hello world" started app app should should be available here)<br>

Remember WordPress, Laravel and Adminer should be pre-installed / pre-configured. No manual steps should be required once the docker containers are started. Adminer should be pre-configured to connect to the WordPress database.






