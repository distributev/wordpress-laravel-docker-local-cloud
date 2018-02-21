# Following should be tested

## Sage PHP changes should work

1. Locally change any Sage PHP file and see the change refreshed when doing browser refresh (localhost URL refresh)

2. git push previous Sage PHP file change to production (AWS) and see the change refreshed when doing browser refresh (AWS url refresh)

3. Locally change Sage's composer.php to add a library (let's say a logging lib) dependency and then execute composer install locally and see the PHP library downloaded and 
then use (test) the new library in any of the Sage's PHP files (try to use the PHP lib)

4. git push previous Sage's composer.php + Sage php file changes ==> on the AWS side Dokku should notice pushes and automatically trigger a composer install execution and
also the new PHP changes in Sage should be enabled when refreshing the AWS url

## Sage JS changes should work

5. Locally change a Sage JS file and the local URL browser refresh should notice the updated JS code

6. git push previous Sage js change and the AWS url browser refresh should reflect the change

7. Locally change Sage's package.json to add a new JS library (let's say lodash) dependency and then execute npm install locally to see the lodash library downloaded and then use (test) the new library in any of the Sage's JS files (try to use the new js lib)

8. git push previous package.json change + Sage JS file changes ==> on the AWS side Dokku should notice pushes and automatically trigger a npm install execution and
also the new JS changes in Sage should take effect when refreshing the AWS url

## Installing a new WordPress plugin using Bedrock's composer.json should work

9. Locally change the main Bedrock composer.php to add a new WordPress plugin (let's say pods-framework/pods) dependency and then execute composer install locally to see the WordPress plugin being downloaded to the correct WordPress plugin directory (next to the existing plugins)

10. git push previous composer.json change ==> on the AWS side Dokku should notice pushes and automatically trigger a composer install execution and the new WordPress pods-framework/pods plugin should be correctly installed on the remote WordPress / bedrock

## Laravel PHP changes should work

11. Locally change Laravel's composer.php to add a new library (let's say a logging lib) dependency and then execute composer install locally to see the PHP library being downloaded
and then use the new library in any of the Laravels's PHP files (refreshing localhost URL should show the Laravel app php change)

12. git push previous Laravel composer.json change + Laravel app php file changes ==> on the AWS side Dokku should notice pushes and automatically trigger a composer install execution and the new PHP changes in Laravel app should be enabled when refreshing the AWS url

## Laravel JS changes should work

13. Locally change Laravel's package.json to add a new library (let's say lodash) dependency and then execute npm install locally to see the lodash js library being downloaded
and then use the new library in any of the Laravels's app JS files (refreshing localhost URL should show the Laravel app JS file change)

14. git push previous Laravel's app package.json change + Laravel app JS file changes ==> on the AWS side Dokku should notice pushes and automatically trigger a npm install execution and also the new JS changes in Laravel app should be enabled when refreshing the AWS url
