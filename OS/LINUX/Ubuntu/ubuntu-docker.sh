#!/bin/bash
# File: 
# Author: Michael Brown
# Date: 
# Description: 


function dockerInstall (){

    #install docker
    sudo apt install docker.io

    #enable the docker service
    sudo systemctl enable docker

    #Start the service
    sudo systemctl start docker

}

function dockerStatus(){

    #make sure docker is running
    sudo systemctl status docker

}
