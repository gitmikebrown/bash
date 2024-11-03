#!/bin/bash
# File: 
# Author: Michael Brown
# Date: 
# Description: 


function dockerUbuntuUp() {
    if ($IsWindows) {
        docker run --name ubuntu-1 `
            -p 8080:80 `
            -p 2222:20 `
            -d ubuntu
    } else {
        sudo docker run --name ubuntu-1 \
            -p 8080:80 \
            -p 2222:20 \
            -d ubuntu
    }
}
dockerUbuntuUp



function dockerUbuntuDown() {
    if ($IsWindows) {
        docker stop ubuntu-1
        docker container rm ubuntu-1
        #docker volume rm ubuntu
        docker image rm ubuntu
    } else {
        sudo docker stop ubuntu-1
        sudo docker container rm ubuntu-1
        #sudo docker volume rm ubuntu
        sudo docker image rm ubuntu
    }
}
dockerUbuntuDown

