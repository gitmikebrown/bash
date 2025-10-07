#!/bin/bash
# File: install-docker-copyPaste.sh
# Author: Michael Brown
# Date: 10/6/2025
# Description: Copy-paste ready commands for installing Docker on Ubuntu
# Usage: Copy individual lines as needed


################################################################################################
#### 🐳 DOCKER INSTALLATION COMMANDS FOR UBUNTU
################################################################################################

function install_docker_APT(){

    #Check for updates
    sudo apt -y update; 
    sudo apt -y upgrade;

    #install docker
    sudo apt -y install docker.io

    #enable the docker service
    sudo systemctl enable docker

    #Start the service
    sudo systemctl start docker
    
    #make sure docker is running
    sudo systemctl status docker

}
#install_docker_APT


function install_docker_yum(){

    #Check for updates
    sudo yum -y update; 
    sudo yum -y upgrade;

    #install docker
    sudo yum -y install docker

    #enable the docker service
    sudo systemctl enable docker

    #Start the service
    sudo systemctl start docker
    
    #make sure docker is running
    sudo systemctl status docker

}
#install_docker_yum
