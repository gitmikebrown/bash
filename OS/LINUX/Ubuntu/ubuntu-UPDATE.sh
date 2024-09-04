#!/bin/bash
# File: ubuntu-UPDATE.sh
# Author: Michael Brown
# Date: September 1, 2024
# Description: Manage Ubuntu updates/upgrades

################################################################################################
#### Ubuntu - Update
################################################################################################

function ubuntuUpdate(){
    sudo apt -y update;
    sudo apt -y upgrade;
    sudo apt -y dist-upgrade;
    sudo apt -y autoremove;
    sudo apt -y autoclean;
}
ubuntuUpdate

################################################################################################
#### Ubuntu - Update to latest version
################################################################################################

function ubuntuUpdateOS(){

    #Check what version is currently installed
    lsb_release -a

    #For ubuntu LTS only
    do-release-upgrade
}

################################################################################################
#### Ubuntu - Upgrade the packages that dont upgrade with apt upgrade
################################################################################################

function ubuntuUpgrade(){

    #List upgradable
    apt list --upgradable

    #After updating/upgrading, some packages are still listed when running the "apt list --upgradable" command.
    #This command will update those packages.  It needs to be run one at a time for each item listed.
    sudo apt-get install --only-upgrade <packagename>

}

################################################################################################
#### Start
################################################################################################

function ubuntuFullUpgrade(){

    #Full upgrade
    sudo apt full-upgrade

}

