#!/bin/bash
# File: 
# Author: Michael Brown
# Date: 
# Description: 

################################################################################################
####   Report on all that is going on
################################################################################################


function docker_status(){
    clear;
    STATUS=$(systemctl is-active docker)
    if [ "$STATUS" = "active" ]; then
        text_Green='\033[0;32m';
        text_reset='\033[0m';
        printf "\n${text_Green}-Networks-----------------------------------------------------${text_reset}\n";
        sudo docker network ls; 
        printf "\n${text_Green}-Volumes-----------------------------------------------------${text_reset}\n";
        sudo docker volume ls; 
        printf "\n${text_Green}-Images--------------------------------------------------------${text_reset}\n";
        sudo docker images; 
        printf "\n${text_Green}-Containers - All------------------------------------------------${text_reset}\n";
        sudo docker ps -a;
        printf "\n${text_Green}-Containers - Currently Running-----------------------------------${text_reset}\n";
        sudo docker ps;
        printf "\n${text_Green}-Docker system usage---------------------------------------------${text_reset}\n";
        sudo systemctl status docker | grep -E 'Memory|CPU'
        printf "\n"
    else
        sudo systemctl status docker | grep -E 'Loaded|Active|TriggeredBy|Docs|Main PID|Tasks|Memory|CPU'
    fi
}

docker_status;
