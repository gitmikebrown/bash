#!/bin/bash
# File: mysql-phpmyadmin.sh
# Author: Michael Brown
# Date: May 2, 2024
# Description: install phpMyAdmin


################################################################################################
#### Update/Upgrade your package repository
################################################################################################


sudo apt -y update; sudo apt -y upgrade;


################################################################################################
####   Installing the MYSQL service
################################################################################################
####
#### 1A. Install the mysql-server package.
#### 		OR
#### 1B. Install mariadb-server package.
#### 2.  Start the MySQL service and enable it.
#### 
####	 Extra
####	 Reinstall the mysql-server service.  This CLI does not delete the database. 
####	 sudo apt-get --reinstall install mysql-server
####
################################################################################################


#1-A
sudo apt-get install -y mysql-server;

#1-B
sudo apt install mariadb-server

#2
sudo systemctl start mysql; sudo systemctl enable mysql;


################################################################################################
####   Securing the MYSQL Service
################################################################################################
####
#### 1.  Update root access password
#### 2.  Secure the database
####
################################################################################################



#1
sudo mysql; ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by 'Qazxsw2!'; exit;

#2

sudo mysql_secure_installation;

#>>Answer the following questions with these answers when running "sudo mysql_secure_installation"
#>Enter the password for user root: type your set password (Qazxsw2!) and then press ENTER.
#>VALIDATE PASSWORD COMPONENT? Press N, then ENTER.
#>Change the password for root? Press N, then ENTER.
#>Remove anonymous users? Press Y, then ENTER.
#>Disallow root login remotely? Press Y, then ENTER.
#>Remove the test database and access to it? Press Y, then ENTER.
#>Reload privilege tables now? Press Y, then ENTER.



################################################################################################
####   Database
################################################################################################
####
#### 1.  Login to the MYSQL service
#### 2.  Database-Create
#### 3.  Database-Delete/Drop
####
################################################################################################

#1
mysql -u root -p;

#2
CREATE DATABASE example_db CHARACTER SET utf8 COLLATE utf8_bin;;

#3
DROP DATABASE example_db;


################################################################################################
####   User - ADD
################################################################################################
####
#### 1.  Login to the MYSQL service
#### 2.  User-Create
#### 3.  User-Privileges
#### 4.  View all users and their domains
####
####	 Note:  	
####	 When setting up a VM within Hyper-V, Hyper-V uses the domain @'vm-name.mshome.net'
####	 It's best to add users with a wild card in the vm-name section, this way if a different
####	 vm is used it wont affect the users login
####
####
################################################################################################

#1
mysql -u root -p;

#2
CREATE USER 'laravel'@'%.mshome.net' IDENTIFIED BY 'Qazxsw2!';
CREATE USER 'laravel'@'localhost' IDENTIFIED BY 'Qazxsw2!';

#3
GRANT ALL PRIVILEGES ON laravel.* to 'laravel'@'%.mshome.net' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON laravel.* to 'laravel'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
quit;


#4
SELECT User, Host FROM mysql.user;


#helpful tool
	sudo apt install net-tools;
	 netstat -an | grep 3306;


################################################################################################
####   User - REMOVE
################################################################################################
####
#### 1. List all existing user
#### 2. Remove all of their privileges
#### 3. Drop the user
#### 4. List all users again to see if they were removed
####
################################################################################################


#1
SELECT User, Host FROM mysql.user;

#2
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'local_vm'@'*.mshome.net';

#3
DROP USER 'local_vm'@'*.mshome.net';

#4
SELECT User, Host FROM mysql.user;

