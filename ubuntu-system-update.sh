#!/bin/bash
# File: ubuntu-UPDATE.sh
# Author: Michael Brown
# Version: 1.2.0
# Date: Updated August 30, 2025
# Description: Menu-driven Ubuntu update/upgrade manager with logging, input validation, and help

################################################################################################
#### Configurable Variables
################################################################################################

SCRIPT_VERSION="1.2.0"
LOGGING_ENABLED=false
LOGFILE="/var/log/ubuntu-update-script.log"

################################################################################################
#### System Summary
################################################################################################

function showSystemSummary(){
#TODO: package manager is not incorporated into summary yet.  apt only at the moment.

    echo "======================================"
    echo " Ubuntu System Summary"
    echo "======================================"

    # Current version
    current_version=$(lsb_release -rs)
    echo "Current Ubuntu Version: $current_version"

    # Upgradeable packages
    echo ""
    echo "Checking for upgradeable packages..."
    upgradable_count=$(apt-get -s upgrade | awk '/^Inst /' | wc -l)
    echo "Packages available for upgrade: $upgradable_count"

    if [ "$upgradable_count" -gt 0 ]; then
        echo "Sample upgradeable packages:"
        apt-get -s upgrade | awk '/^Inst / {print $2}' | head -5
    fi

    # Full-upgrade simulation
    echo ""
    echo "Checking full-upgrade impact..."
    full_upgrade_preview=$(apt-get -s dist-upgrade | awk '/^Inst /')
    if [ -z "$full_upgrade_preview" ]; then
        echo "No packages require full-upgrade."
    else
        echo "Packages affected by full-upgrade:"
        echo "$full_upgrade_preview" | head -5
    fi

    # Release upgrade availability
    echo ""
    echo "Checking for Ubuntu release upgrade..."
    next_version=$(do-release-upgrade -c | grep "New release" | awk -F': ' '{print $2}')
    if [ -z "$next_version" ]; then
        echo "You are running the latest supported release."
    else
        echo "New Ubuntu release available: $next_version"
    fi

    echo "======================================"
    pause
}

################################################################################################
#### Utility Functions
################################################################################################

function log(){
    if [ "$LOGGING_ENABLED" = true ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
    fi
}

function pause(){
    read -p "Press [Enter] to return to the menu..."
}

function confirm(){
    read -p "$1 [y/N]: " response
    [[ "$response" =~ ^[Yy]$ ]]
}

################################################################################################
#### Detect Package Manager
################################################################################################

function detectPackageManager() {
    if command -v yum >/dev/null 2>&1; then
        echo "yum"
    elif command -v apt >/dev/null 2>&1; then
        echo "apt"
    else
        echo "unknown"
    fi
}

################################################################################################
#### Update
################################################################################################

#### apt - Standard Update

function aptUpdate(){
    log "Starting standard update and cleanup"
    echo "Running standard update and cleanup..."
    sudo apt -y update
    sudo apt -y upgrade
    sudo apt -y dist-upgrade
    sudo apt -y autoremove
    sudo apt -y autoclean
    log "Standard update complete"
    pause
}

#### yum - AWS-style Update

function yumUpdate() {
    log "Starting AWS-style update and cleanup"
    echo "Running yum-based update and cleanup..."
    sudo yum -y update
    sudo yum -y upgrade
    sudo yum -y autoremove
    sudo yum -y clean all
    log "AWS-style update complete"
    pause
}

#### Run Appropriate Update Based on Detected Package Manager

function runUpdate() {
    local pkgManager
    pkgManager=$(detectPackageManager)

    case "$pkgManager" in
        yum)
            yumUpdate
            ;;
        apt)
            aptUpdate
            ;;
        esac
}

################################################################################################
#### Ubuntu - Update to latest version
################################################################################################

function ubuntuUpdateOS(){
    echo "Checking current Ubuntu version..."
    current_version=$(lsb_release -rs)
    echo "You are currently running Ubuntu $current_version."

    # Fetch available upgrade version (requires update-manager-core)
    next_version=$(do-release-upgrade -c | grep "New release" | awk -F': ' '{print $2}')

    if [ -z "$next_version" ]; then
        echo "You are already running the latest supported version."
        log "OS upgrade check: already at latest version ($current_version)"
    else
        echo "A new Ubuntu version is available: $next_version"
        if confirm "Would you like to upgrade to Ubuntu $next_version?"; then
            log "User confirmed upgrade from $current_version to $next_version"
            sudo do-release-upgrade
            log "OS upgrade initiated"
        else
            echo "OS upgrade canceled."
            log "OS upgrade canceled by user"
        fi
    fi
    pause
}

################################################################################################
#### Ubuntu - Full upgrade
################################################################################################

function ubuntuFullUpgrade(){
    log "Checking for packages requiring full upgrade"
    echo "Checking for packages requiring full upgrade..."

    # Simulate full-upgrade to preview changes
    pending=$(apt-get -s dist-upgrade | awk '/^Inst /')

    if [ -z "$pending" ]; then
        echo "No packages require a full upgrade. System is up to date."
        log "Full upgrade skipped — no packages pending"
    else
        echo "The following packages are eligible for full upgrade:"
        echo "$pending"
        echo ""
        if confirm "Would you like to proceed with the full upgrade?"; then
            log "User confirmed full upgrade"
            echo "Running full upgrade..."
            sudo apt-get -y dist-upgrade
            log "Full upgrade complete"
        else
            echo "Full upgrade canceled."
            log "Full upgrade canceled by user"
        fi
    fi
    pause
}

################################################################################################
#### Help Menu
################################################################################################

function showHelp(){
    echo "Ubuntu Update Manager - Version $SCRIPT_VERSION"
    echo ""
    echo "Menu Options:"
    echo "  1) Standard Update & Cleanup - Runs apt update/upgrade and cleanup commands"
    echo "  2) Upgrade to Latest Ubuntu Version - Uses do-release-upgrade for LTS upgrades"
    echo "  3) Full Upgrade - Runs apt full-upgrade"
    echo "  4) Help - Show this usage summary"
    echo "  5) Exit - Quit the script"
    pause
}

################################################################################################
#### Menu Interface
################################################################################################

function showMenu(){
    clear
    echo "======================================"
    echo " Ubuntu Update Manager - v$SCRIPT_VERSION"
    echo "======================================"
    echo "1) Standard Update & Cleanup"
    echo "2) Upgrade to Latest Ubuntu Version"
    echo "3) Full Upgrade"
    echo "4) Help"
    echo "5) Exit"
    echo "======================================"
    read -p "Choose an option [1-5]: " choice

    if ! [[ "$choice" =~ ^[1-5]$ ]]; then
        echo "Invalid input. Please enter a number between 1 and 5."
        sleep 2
        return
    fi

    case $choice in
        1) runUpdate ;;
        2) ubuntuUpdateOS ;;
        3) ubuntuFullUpgrade ;;
        4) showHelp ;;
        5) echo "Exiting..."; log "Script exited by user"; exit 0 ;;
    esac
}

################################################################################################
#### Start Script with Persistent Loop
################################################################################################

showSystemSummary
while true; do
    showMenu
done