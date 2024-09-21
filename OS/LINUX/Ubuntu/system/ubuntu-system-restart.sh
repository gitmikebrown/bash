#!/bin/bash
# File: 
# Author: Michael Brown
# Date: 
# Description: 

################################################################################################
####   Shutdown
################################################################################################





################################################################################################
####   Restart
################################################################################################

function ubuntuReboot(){
    
    text_Red='\033[0;31m'
    text_reset='\033[0m';
    minutes=$1
    current_system_time="Current system time: $(date +"%T")";
    message="The compter will restart in ${minutes}"

    if [ -n "$minutes" ]; then    
        if [ "$minutes" -eq 0 ]; then

            #reboot now
            output=$(sudo reboot now 2>&1)
            printf "\n${text_Red}${output}${text_reset}\n\n"
            exit 1
        else
            echo "$current_system_time"
            echo "Scheduling reboot in $minutes minutes with message: $message"
            output=$(sudo shutdown -r +$minutes "$message" 2>&1)
            printf "\n${text_Red}${output}${text_reset}\n\n";
            exit 1
        fi
    else
        echo "Usage: $0 <minutes>"
        exit 1
    fi
}
ubuntuReboot 20;