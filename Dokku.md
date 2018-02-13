My first option is with Dokku inside docker (just to have 100% solution deployed inside Docker which offers portability 
across cloud vendors)

https://github.com/dokku/dokku/issues/1076

If "Docker hosted dokku" solution will prove too hacky and different from the official Dokku installation guide (I also need all components installations to follow official installation steps ) I am also fine if you'll provide all components
inside docker except Dokku.

<strong>Alternative Dokku installation</strong>

For Dokku (which you said needs to run directly on EC2 which will add additional server management overhead / lost cloud provider portability)
it is fine to create a separate dokku.bat provisioning script powered by ansible also.

Provided that dokku.bat ansible script will be plain stupid and easy to understand (is 25 lines of ansible script achievable for dokku.bat)
