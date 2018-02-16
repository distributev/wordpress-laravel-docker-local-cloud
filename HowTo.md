
# Setup the local environment

1- Clone this project
2- Go to setup folder
3- Setup the local environment using
```
PROJECT_PATH=path_to_your_new_project WP_INIT=yes docker-compose up
```
You need to provide the path to the project where the setup will create the new bedrock project
`WP_INIT` has to be set to `yes` the first time in order to initialize the project (bedrock, sage,...), when ommited, the project will not be initialized and this assumes that `PROJECT_PATH` already contains bedrock project