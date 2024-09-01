#!/bin/bash
# File: 
# Author: Michael Brown
# Date: 
# Description: 

################################################################################################
####   MySql
################################################################################################

function mysql_up(){

    mysql_root_password=green
    mysql_user_name=brown1
    mysql_user_password=green3
    
    #Mysql Latest
    sudo docker run --name c-mysql-1 \
    -p 3306:3306 \
    -v v-mysql-1:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=$mysql_root_password \
    -e MYSQL_ONETIME_PASSWORD=true \
    -e MYSQL_USER=$mysql_user_name \
    -e MYSQL_PASSWORD=$mysql_user_password \
    -e MYSQL_DATABASE=laravel \
    -d mysql

}

################################################################################################
####   MySql
################################################################################################


function postgres_up(){

       docker run --name my-postgres-1 \
        -p 5432:5432 \
        -e POSTGRES_PASSWORD=mysecretpassword \
        -d postgres

}

################################################################################################
####   Build container
################################################################################################


    printf "\n------------------------------------";
    printf "\n-------------*OPTIONS*---------------";
    printf "\n------------------------------------";
    printf "\n\t1 mysql_build";
    printf "\n\t2 postgres_build";
    printf "\n\n"
    read -p "Enter an option: " DB_choice;


case $DB_choice in 
   
    1)
        mysql_up
        ;;
    
    2)
        postgres_up
 
        ;;
esac