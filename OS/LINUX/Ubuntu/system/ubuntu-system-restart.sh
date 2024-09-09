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

    minutes=0
    message='The compter will restart in $minutes'

    if [ $minutes -eq 0 ]; then

        #The best option
        sudo reboot now
    else
        #20 min
        sudo shutdown -r +$minutes $message
    fi
}
#ubuntuReboot;