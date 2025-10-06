#!/bin/bash
# File: 
# Author: Michael Brown
# Date: 
# Description: 


function install_docker(){

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
