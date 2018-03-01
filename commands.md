
# Start Project (project_name it is like a namespace)
_docker-compose -p project_name up -d --build_

then you must use the same name with other docker-compose commands

* _docker-compose -p project_name ps_
* _docker-compose -p project_name logs_

# Stop all running containers

_docker stop $(docker ps -aq)_

# Remove all containers

_docker rm $(docker ps -aq)_

# Remove all images

_docker rmi $(docker images -q)_
