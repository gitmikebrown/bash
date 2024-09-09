#!/bin/bash
# File: 
# Author: Michael Brown
# Date: 
# Description: 


function install_dockerCompose(){

    #Install docker compose
    #https://docs.docker.com/compose/install/linux/
    sudo apt -y update
    sudo apt -y upgrade;
    sudo apt-get install docker-compose-plugin

} 
#install_dockerCompose

