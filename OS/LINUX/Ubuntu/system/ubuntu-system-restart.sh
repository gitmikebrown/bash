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
#!/bin/bash
function ubuntuReboot(){
    
    text_Red='\033[0;31m'
    text_reset='\033[0m';
    minutes=$1
    message=(
       "The computer will restart in ${minutes}" 
       "Current system time: $(date +"%a %Y-%m-%d %T")"
       "Scheduled reboot time: $(date -d \"+${minutes} minutes\" +\"%a %Y-%m-%d %T\")"
    )

    if [ -n "$minutes" ]; then    
        if [ "$minutes" -eq 0 ]; then

            #reboot now
            output=$(sudo reboot now 2>&1)
            printf "\n${text_Red}${output}${text_reset}\n\n"
            #exit 1
        else
            output=$(sudo shutdown -r +$minutes 2>&1)
            printf "\n${text_Red} \
            ${message[0]}\n \
            ${message[1]}\n\ 
            ${output} \
            ${text_reset}\n\n"
            #exit 1
        fi
    else
        echo "Usage: ${0} <minutes>"
        #exit 1
    fi
}
ubuntuReboot 20;