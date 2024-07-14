#!/bin/bash
# File: laravel-env-management.sh
# Author: Michael Brown
# Date: July 4, 2024
# Description: Manage Laravel .env file


################################################################################################
####   vars
################################################################################################
####
####    Notes: fn=file name
################################################################################################

fn_production="production"
fn_development="development"

################################################################################################
####   helpful links
################################################################################################
####
####    Link:https://stackoverflow.com/questions/57582453/is-there-a-suggested-list-of-values-for-laravels-app-env-variable-found-in-the
####    Notes: Link provides APP_ENV options.  Options are: local/development/staging/production
####
####    Link:https://panjeh.medium.com/laravel-app-env-local-app-env-production-difference-aa9662ac81d0
####    Notes: Link provides a good APP_ENV explanation.
####
################################################################################################


################################################################################################
####   Build "development" .env file
################################################################################################
####
####    Notes: None
####    Steps:
####        A. Create development env file
####        B. Change env APP_DEBUG to true
####        C. Set APP_ENV to development
####        D. Generate API_KEY
####
################################################################################################

function build_dev_env(){

#TODO#1: check if the files exist.  If they do, ask if this should overwrite them.
#TODO#2: make sure to att .env.dev to the .gitignore file
    #A
    cp .env .env.$fn_development;

    #B
    sed -i "s/APP_DEBUG=false/APP_DEBUG=true/g" .env.$fn_development;

    #C
    sed -i "s/APP_ENV=$fn_production/APP_ENV=$fn_development/g" .env.$fn_development;

    #D
    php artisan key:generate --env=$fn_development

}

################################################################################################
####   Build "production" .env file
################################################################################################
####
####    Notes: None
####
####    Steps:
####        A. Create production env file
####        B. Change env APP_DEBUG to false
####        C. Set APP_ENV to production
####
################################################################################################

function build_prod_env(){
#TODO#2: make sure to add .env.dev to the .gitignore file
    #A
    cp .env.example .env.$fn_production;

    #B
    sed -i 's/APP_DEBUG=true/APP_DEBUG=false/g' .env.$fn_production;

    #C
    sed -i "s/APP_ENV=$fn_development/APP_ENV=$fn_production/g" .env.$fn_production;

}

################################################################################################
####   Encrypt .env files
################################################################################################
####
####    Notes: None
####
####    Steps:
####        A. Encrypt development and production files
####        B. Delete unencrypted development and production files
####
################################################################################################

function encrypt_env(){

    #A
    php artisan env:encrypt --env=$fn_development --key=base64:2aW5VRyXlCr5ouiSIuxBwSwe0tbQMD6L38qORz/dvfI=;
    php artisan env:encrypt --env=$fn_production --key=base64:5rx2wFITSetiyYT+wb5iro2jFso/QgWzfRhhk0YSbVU=;

    #B
    rm .env.$fn_development;
    rm .env.$fn_production;

}

################################################################################################
####   Decrypt .env files
################################################################################################
####
####    Notes: None
####
####    Steps:
####        A. Decrypt development and production files
####        B. Delete encrypted development and production files
####
################################################################################################

function decrypt_env(){

    #A
    php artisan env:decrypt --env=$fn_development --key=base64:2aW5VRyXlCr5ouiSIuxBwSwe0tbQMD6L38qORz/dvfI=;
    php artisan env:decrypt --env=$fn_production --key=base64:5rx2wFITSetiyYT+wb5iro2jFso/QgWzfRhhk0YSbVU=;

#TODO: need to check to see if the above was completed.  If not, do not rm them
    #B
    rm .env.$fn_development.encrypted;
    rm .env.$fn_production.encrypted;

}

################################################################################################
####   Activate development env
################################################################################################
####
####    Notes: None
####
####    Steps:
####        A. Activate development env
####
################################################################################################

function activate_dev(){
#TODO: Check if file is encrypted first. If they are ask if they should be decrypted.
    #A
    cp .env.$fn_development .env;

}

################################################################################################
####   Activate production env
################################################################################################
####
####    Notes: None
####
####    Steps:
####        A. Activate production env
####
################################################################################################

function activate_prod(){
#TODO: Check if file is encrypted first. If they are ask if they should be decrypted.
    #A
    cp .env.$fn_production .env;

}
################################################################################################
####   Cash env
################################################################################################
####
####    Notes: Do not run option A on a development server.
####
####    Options:
####        A. Cashe env
####        B. Clear env cash
####
################################################################################################

function cashe_env(){

    #A
    php artisan config:cache;

}

function clear_cashe(){

    #B
    php artisan config:clear;

}

################################################################################################
####   Delete Env Files
################################################################################################
####
####    Notes:
####
################################################################################################

function env_delete(){

    printf "\n------------------------------------";
    printf "\n-------------*OPTIONS*---------------";
    printf "\n------------------------------------";
    printf "\n\t1 Delete unencrypted env files?";
    printf "\n\t2 Delete encrypted env files?";
    printf "\n\t3 Delete both";
    printf "\n\t4 Cancel"
    printf "\n\n"
    read -p "Enter an option: " chosen_delete_option;

    case $chosen_delete_option in
        1)
            rm .env.$fn_development
            rm .env.$fn_production
            ;;
        2)
            rm .env.$fn_development.encrypted
            rm .env.$fn_production.encrypted
            ;;
        3)
            rm .env.$fn_development.encrypted
            rm .env.$fn_production.encrypted
            rm .env.$fn_development
            rm .env.$fn_production
            ;;
        4)
            ;;
    esac
}

################################################################################################
####   Generate an env key
################################################################################################
####
####    Notes: Generates a key for the env APP_KEY.
####
################################################################################################

function gen_env_key(){

    php artisan key:generate

}

################################################################################################
####   Generate an env key
################################################################################################
####
####    function options:
####        build_dev_env()
####        build_prod_env()
####        encrypt_env()
####        decrypt_env()
####        activate_dev()
####        activate_prod()
####        cashe_env()
####        clear_cashe()
####        gen_env_key()
####
################################################################################################

env_counter=false
menu_ask=0

while ! $env_counter; do

    if [ $menu_ask -eq 0 ]; then
        read -p "Do you want a fancy menu? (y n): " fancy_menu_choice;
        menu_ask=1
    fi

    if [ "$fancy_menu_choice" = "y" ]; then
        #https://bash.cyberciti.biz/guide/Bash_display_dialog_boxes
        options=(
            0 "Exit" on
            1 "Build env files" off
            2 "Encrypt env files" off
            3 "Decrypt env files" off
            4 "Set environment to production" off
            5 "Set environment to development" off
            8 "Delete env files" off
        )
        selected_option=$(dialog --backtitle "Laravel .env file options" \
        --radiolist "Select an option:" 16 60 10 "${options[@]}" 2>&1 >/dev/tty)

    else
        printf "\n------------------------------------";
        printf "\n-------------*OPTIONS*--------------";
        printf "\n------------------------------------";
        printf "\n\t1 Build env files";
        printf "\n\t2 Encrypt env files";
        printf "\n\t3 Decrypt env files";
        printf "\n\t4 Set environment to production";
        printf "\n\t5 Set environment to development";
        printf "\n\t8 Delete env files"
        printf "\n\t0 Exit"
        printf "\n\n"

        read -p "Enter an option: " selected_option;

    fi

    printf "\n"
    echo "You chose $selected_option";
    printf "\n"

    case $selected_option in
        1)
            build_dev_env
            build_prod_env
            ;;
        2)
            encrypt_env
            ;;
        3)
            decrypt_env
            ;;
        4)
            activate_prod
            ;;
        5)
            activate_dev
            ;;
        8)
            env_delete
            ;;
        0)
            env_counter=true
            ;;
    esac
done


