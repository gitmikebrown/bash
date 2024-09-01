#!/bin/bash
# File: 
# Author: Michael Brown
# Date: 
# Description: 


################################################################################################
#### Groups
################################################################################################

#View all groups and users in those groups
    cat /etc/group

#View groups with the user www-data
    cat /etc/group | grep www-data

#View groups that you are in
    cat /etc/group | grep $USER;

#delete a user from a group
    #gpasswd --delete user group
    sudo gpasswd --delete mike www-data
    
#delete a group
    groupdel mygroup

#Create Groups
    sudo groupadd frontEnd;
    sudo groupadd appDev;
    sudo groupadd dataBase;
    sudo groupadd webmasters;

#Add self to all groups
    sudo usermod --append --groups frontEnd $USER;
    sudo usermod --append --groups appDev $USER;
    sudo usermod --append --groups dataBase $USER;
    sudo usermod --append --groups webmasters $USER;

    sudo usermod --append --groups www-data $USER;
	sudo usermod --append --groups gpio rdesktop;



#EC2 Ubuntu Groups to be added to

USER2ADD=brown;
sudo usermod --append --groups adm $USER2ADD;
sudo usermod --append --groups dialout $USER2ADD;
sudo usermod --append --groups cdrom $USER2ADD;
sudo usermod --append --groups floppy $USER2ADD;
sudo usermod --append --groups sudo $USER2ADD;
sudo usermod --append --groups audio $USER2ADD;
sudo usermod --append --groups dip $USER2ADD;
sudo usermod --append --groups video $USER2ADD;
sudo usermod --append --groups plugdev $USER2ADD;
sudo usermod --append --groups netdev $USER2ADD;
sudo usermod --append --groups lxd $USER2ADD;



#Ensure /etc/gshadow is in sync with changes to /etc/group  AKA RUN AFTER ANY CHANGES
    sudo grpck;
	sudo shutdown -r now;

#helpfull link
#https://www.redhat.com/sysadmin/linux-groups
#More info found here: https://ubuntu.com/server/docs/how-to-use-apache2-modules  
