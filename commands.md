
# Start Project (project_name it is like a namespace)

First time after git cloning the project

**_docker-compose -p project_name up -d --build_**

Sub-sequent executions

**_docker-compose -p aws4 up_**

then you must use the same name with other docker-compose commands

* **_docker-compose -p project_name ps_**
* **_docker-compose -p project_name logs_**

# Stop all running containers

**_docker stop $(docker ps -aq)_**

# Remove all containers

**_docker rm $(docker ps -aq)_**

# Remove all images

**_docker rmi $(docker images -q)_**
