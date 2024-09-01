#!/bin/bash
# File: 
# Author: Michael Brown
# Date: 
# Description: 


sudo nano /etc/ssh/sshd_config


#Change port 22 to something else
#Change "AddressFamily any" to "AddressFamily inet" and remove the # to enable it.
#Change "PermitRootLogin yes" to no
$Change "PasswordAuthentication yes" to no


#restart the service
sudo systemctl restart sshd
