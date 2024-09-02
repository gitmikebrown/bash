#!/bin/bash
# File: 
# Author: Michael Brown
# Date: 
# Description: 


function dockerUbuntuUp(){

       sudo docker run --name ubuntu-1 \
        -p 8080:80 \
        -p 2222:20 \
        -d ubuntu

}
dockerUbuntuUp;




function dockerUbuntuDown(){

    sudo docker stop ubuntu-1;
    sudo docker container rm ubuntu-1;
    #sudo docker volume rm v-mysql-1;
    sudo docker image rm ubuntu;

}
dockerUbuntuDown;