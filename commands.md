
# Start Project (project_name it is like a namespace)

First time after git cloning the project

**_docker-compose -p $project_name$ up --build_** or if you need to run in detached mode **_docker-compose -p $project_name$ up -d --build_**

Sub-sequent executions

**_docker-compose -p $project_name$ up_**

then you must use the same name with other docker-compose commands

# View Services

* **_docker-compose ps_**
* **_docker-compose -p $project_name$ ps_**

# View Logs

* **_docker-compose logs -f $service_name$_**
* **_docker-compose -p $project_name$ logs_**
* **_docker-compose -p $project_name$ logs -f $service_name$_**

# Restart all containers

**_docker-compose -p $project_name$ restart_**

# Restart a specific container (service)

**_docker-compose -p $project_name$ restart $service_name$_**

# Stop all running containers

**_docker stop $(docker ps -a -q)_**

# The easiest way to delete the volume is to delete the whole stack

**_docker-compose -p $project_name$ down -v_**

# Remove all containers

**_docker rm $(docker ps -a -q)_**

# Remove all images

**_docker rmi $(docker images -q)_**

# Purging All Unused or Dangling Images, Containers, Volumes, and Networks

Docker provides a single command that will clean up any resources — images, containers, volumes, and networks — that are dangling (not associated with a container):

**_docker system prune_**

To additionally remove any stopped containers and all unused images (not just dangling images), add the -a flag to the command:

**_docker system prune -a_**
