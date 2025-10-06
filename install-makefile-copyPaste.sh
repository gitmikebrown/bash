#!/bin/bash
# File: install-makefile-copyPaste.sh
# Author: Michael Brown
# Description: Copy-paste ready commands for installing make across different Linux distributions
# Usage: Copy individual lines as needed

################################################################################################
#### 🏗️ MAKE INSTALLATION COMMANDS
################################################################################################

# Ubuntu/Debian - Install make
sudo apt-get update && sudo apt-get install -y make

# Amazon Linux 2 - Install make
sudo yum update -y && sudo yum install -y make

# Amazon Linux 2023 / RHEL 8+ - Install make
sudo dnf update -y && sudo dnf install -y make

# Fedora - Install make
sudo dnf update -y && sudo dnf install -y make

# Alpine Linux - Install make
apk update && apk add make

# Arch Linux - Install make
sudo pacman -Syu make

# SUSE / openSUSE - Install make
sudo zypper refresh && sudo zypper install -y make

################################################################################################
#### 🔍 INFORMATION & DEBUGGING
################################################################################################

# Check make version and build info
make --version

# Display make help and usage options
make --help

# Show all built-in variables and rules (detailed database)
make --print-data-base

# Show all built-in variables and rules (short form)
make -p

# Print debugging information (general)
make --debug

# Print debugging info with verbose details
make --debug=verbose

# Print debugging info for variables only
make --debug=variables

# Print debugging info for implicit rules
make --debug=implicit

# Warn about undefined variables
make --warn-undefined-variables

# Check if make is installed and show location
which make

################################################################################################
#### 🚀 EXECUTION CONTROL
################################################################################################

# Dry run - show what would be executed without running
make --dry-run

# Dry run (short form)
make -n

# Run with multiple parallel jobs (specify number)
make --jobs=4

# Run with parallel jobs (short form)
make -j4

# Run with unlimited parallel jobs
make -j

# Keep going on errors (don't stop on first error)
make --keep-going

# Keep going on errors (short form)
make -k

# Silent mode (don't print commands being executed)
make --silent

# Silent mode (short form)
make -s

# Ignore errors and continue execution
make --ignore-errors

# Ignore errors (short form)
make -i

# Print commands as they are executed
make --print-directory

# Don't print working directory changes
make --no-print-directory

################################################################################################
#### 📁 FILE & DIRECTORY OPTIONS
################################################################################################

# Specify which makefile to use (custom filename)
make --file=Makefile.custom

# Specify makefile (short form)
make -f Makefile.custom

# Change to directory before reading makefiles
make --directory=/path/to/dir

# Change to directory (short form)
make -C /path/to/dir

# Search for included files in specified directory
make --include-dir=/path/to/includes

# Include directory (short form)
make -I /path/to/includes

# Include additional makefiles from directory
make --include-dir=/usr/local/include

################################################################################################
#### 🔧 ADVANCED OPTIONS
################################################################################################

# Force rebuild of target even if files are up to date
make --always-make

# Force rebuild (short form)
make -B

# Touch files instead of running commands (update timestamps)
make --touch

# Touch files (short form)
make -t

# Question mode - exit status indicates if target is up to date
make --question

# Question mode (short form)
make -q

# Override environment variables with makefile variables
make --environment-overrides

# Set variable from command line (override makefile)
make VARIABLE=value

# Set multiple variables from command line
make CC=gcc CFLAGS="-O2 -g" LDFLAGS="-static"

# Run make with specific shell
make SHELL=/bin/bash

# Run make with verbose output (if makefile supports it)
make VERBOSE=1

################################################################################################
#### 📊 ANALYSIS & UTILITIES
################################################################################################

# List all targets defined in makefile
make --print-data-base --dry-run --question 2>/dev/null | grep "^[^.#].*:" | cut -d: -f1 | sort -u

# Show all variables and their values
make --print-data-base --dry-run --question | grep "^[a-zA-Z].*=" | sort

# Check makefile syntax without executing
make --dry-run --question >/dev/null 2>&1 && echo "Syntax OK" || echo "Syntax Error"

# Time the make process execution
time make

# Show what files make would read (requires strace)
strace -e trace=openat make --dry-run 2>&1 | grep Makefile

# Profile make execution with timing
make --debug=basic --print-data-base

# Print make version in machine-readable format
make --version | head -1

# Show makefile database structure
make --print-data-base --dry-run --question | grep "^# Make data base"


