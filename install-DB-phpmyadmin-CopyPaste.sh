#!/bin/bash
# File: mysql-phpmyadmin.sh
# Author: Michael Brown
# Date: May 2, 2024
# Description: install phpMyAdmin


################################################################################################
#### Update/Upgrade your package repository
################################################################################################

#LTS update
do-release-upgrade

sudo apt -y update; sudo apt -y upgrade;

################################################################################################
#### Install PHP my admin
################################################################################################

sudo apt install -y phpmyadmin


################################################################################################
#### Update Apache file
################################################################################################

sudo nano /etc/apache2/sites-enabled/000-default.conf


#add "Include /etc/phpmyadmin/apache.conf" to the active Apache file 

sudo echo "<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
        Include /etc/phpmyadmin/apache.conf
</VirtualHost>
" | sudo tee /etc/apache2/sites-available/laravel.conf;

################################################################################################
#### Restart Apache
################################################################################################

sudo systemctl reload apache2


