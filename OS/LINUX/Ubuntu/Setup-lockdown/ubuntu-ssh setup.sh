#!/bin/bash
# File: 
# Author: Michael Brown
# Date: 
# Description: 


################################################################################################
#### Setup SSH
#### 
####  Notes: this should be run from a putty session
#### 
#### https://www.youtube.com/watch?v=33dEcCKGBO4&t=293s
#### 
################################################################################################

#Linux
mkdir ~/.ssh && chmod 700 ~/.ssh

#Windows Power shell
#-Password is not needed.  Leave blank and hit enter
#-Dont override anything.  Change the name if needed
#-The larger the number the better
ssh-keygen -b 4096

scp $env:USERPROFILE/.ssh/id_rsa.pub USERNAME@IPADDRESS:~/.ssh/authorized_keys
#After scp, convert the key to a putty key



#Type the following:
	ssh_user="${USER}_ssh"
	sudo adduser $ssh_user
	sudo usermod --append --groups sudo $ssh_user;


#Check to see what ports are open
sudo ss -tupln


#Get the IP Address
	hostname -I


#From AWS labs - IFT560
ssh-keygen -t rsa -f ~/.ssh/id_rsa
