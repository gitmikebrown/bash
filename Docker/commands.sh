
Docker cheatsheet
https://docs.docker.com/get-started/docker_cheatsheet.pdf

docker run -d [image name] will run an image in the background


################################################################################################
####   Delete everything - NUKE the server
################################################################################################

sudo docker system prune --all --volumes

################################################################################################
####   containers
################################################################################################

#all running containers
docker ps

#all containers
docker ps -a

#List containers
#more info at: https://docs.docker.com/reference/cli/docker/container/ls/
sudo docker containers ls

#show only the container names
sudo docker ps -a --format "table {{.Names}}"

#Start a container
docker start {CONTAINER ID}

$Stop a container
docker stop {CONTAINER ID}

################################################################################################
####   image
################################################################################################

#show all
docker images

#docker pull [image]:[version] - if no version is added then the latest version will be pulled
#EX>docker pull postgres:16.3


#remove an image
docker rmi [image ID]



################################################################################################
####   volumes
################################################################################################

sudo docker volume ls

sudo docker volumen rm [VOLUME_NAME]


#Inspect a volume
docker volume inspect [VOLUME_NAME]

