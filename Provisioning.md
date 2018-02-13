Instead of the Amazon EB cli (or Amazon AWS cli) provision.bat script can be implemented using Ansible given that

* The script size / complexity will be kept to a minimum needed to achieve the docker images provisioning part (is 25 lines of ansible code achievable?)
* The only responsibility of the provision script should be to do only the initial set-up / upload for the (already) pre-configured docker images
* The provision script should not install any component (e.g. bedrock/wordpress, sage theme, laravel, dokku, composer, etc.)


Note* - The components installation (e.g. bedrock/wordpress, sage theme, laravel, dokku, composer, etc.) should be bundled inside 
the corresponding docker files and each should be done using the installation step commands described on their corresponding "Installation" 
guides

Following installation commands should be bundled inside the corresponding dockerfiles (not in the provision ansible script)

* https://getcomposer.org/doc/00-intro.md
* https://roots.io/bedrock/docs/installing-bedrock/
* https://github.com/roots/sage
* https://laravel.com/docs/5.5/installation
* http://dokku.viewdocs.io/dokku/getting-started/installation/
