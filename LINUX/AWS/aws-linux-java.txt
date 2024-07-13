#!/bin/bash
# File: java.sh
# Author: Michael Brown
# Date: May 11, 2024
# Description: install and run java on aws linux


################################################################################################
#### Java
################################################################################################

java -version

yum install java-1.8.0-openjdk

#if more than one OpenJDK is installed, to change to the preferred version
alternatives --config java