

################################################################################################
####   Report on all that is going on
################################################################################################



text_Green='\033[0;32m'
text_reset='\033[0m'
clear;
printf "\n\n${text_Green}-networks-----------------------------------------------------${text_reset}\n\n";
sudo docker network ls; 
printf "\n\n${text_Green}-volumes-----------------------------------------------------${text_reset}\n\n";
sudo docker volume ls; 
printf "\n${text_Green}-images--------------------------------------------------------${text_reset}\n\n";
sudo docker images; 
printf "\n${text_Green}-containers-All------------------------------------------------${text_reset}\n\n";
sudo docker ps -a;
printf "\n${text_Green}-containers-currently running-----------------------------------${text_reset}\n\n";
sudo docker ps;
printf "\n\n";