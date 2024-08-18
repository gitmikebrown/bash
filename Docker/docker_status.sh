

################################################################################################
####   Report on all that is going on
################################################################################################


function docker_status(){
    text_Green='\033[0;32m';
    text_reset='\033[0m';
    clear;
    printf "\n\n${text_Green}-Networks-----------------------------------------------------${text_reset}\n\n";
    sudo docker network ls; 
    printf "\n\n${text_Green}-Volumes-----------------------------------------------------${text_reset}\n\n";
    sudo docker volume ls; 
    printf "\n${text_Green}-Images--------------------------------------------------------${text_reset}\n\n";
    sudo docker images; 
    printf "\n${text_Green}-Containers - All------------------------------------------------${text_reset}\n\n";
    sudo docker ps -a;
    printf "\n${text_Green}-Containers - Currently Running-----------------------------------${text_reset}\n\n";
    sudo docker ps;
    printf "\n\n";

}

docker_status;