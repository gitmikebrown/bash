#!/bin/bash
# File: 
# Author: Michael Brown
# Date: 
# Description: 

################################################################################################
####   Restart
################################################################################################

#!/bin/bash
function ubuntuReboot() {
    

    # Validate timeValue is a number or "0"
    #if ! [[ "$timeValue" =~ ^[0-9]+$ ]]; then
    #    echo $errorMessage
    #    return 1
    #fi


    # Text colors
    text_Red='\033[0;31m'
    text_Green='\033[0;32m'
    text_reset='\033[0m'
    
    # The value coming in should be 20m or 20h or 20d for minutes, hours, or days.
    incomingValue=$1
    # Break the D,H,M off the end
    timePeriod="${incomingValue: -1}"
    timeValue="${incomingValue::-1}"
    
    # Error message to help users
    errorMessage="Invalid time period. Use 'm' for minutes, 'h' for hours, or 'd' for days. Example 20m"

    # System time message
    timeNowMessage="Current system time: $(date +'%a %Y-%m-%d %T %Z')"
    
    # Check to see if incoming value is null
    if [ -z "$incomingValue" ]; then
        read -p "Do you want to reboot now? (y/n): " choice1
        if [[ "$choice1" =~ ^[Yy]$ ]]; then
            sudo reboot now
        else
            echo $errorMessage
        fi
        return 1
    # Cancel the shutdown
    elif [ "${incomingValue,,}" == "c" ]; then #The ,, converts the incomingValue to lowercase
        printf "${text_Green}"
        sudo shutdown -c
        printf "${text_reset}"
        return 0
    # Immediate reboot
    elif [ "$incomingValue" -eq 0 ]; then
        printf "\n${text_Red}"
        printf "${timeNowMessage}\n"
        sudo reboot now
        printf "${text_reset}"
        return 0
    else
        #  breakdown the time into minutes
        case "$timePeriod" in
            [dD]) restartInMinutes=$((timeValue * 24 * 60)) ;;  # 24 hours in a day, 60 min in an hour
            [hH]) restartInMinutes=$((timeValue * 60)) ;; # 60 min in an hour
            [mM]) restartInMinutes=$timeValue ;;
            *) echo $errorMessage; return 1 ;;
        esac
        
        # Set and run the restart
        output=$(sudo shutdown -r +$restartInMinutes 2>&1 | sed "s/, use 'shutdown -c' to cancel.//")  # capture the message output and remove some text
        
        printf "\n${text_Red}"
        printf "\t\tThe computer will restart in ${restartInMinutes} minutes.\n\n"
        printf "\t\t${timeNowMessage}\n"
        printf "\t\t${output}\n\n"
        printf "\t\tUse 'ubuntuReboot c' to cancel.\n"
        printf "${text_reset}\n"
    fi
}

ubuntuReboot 20m
