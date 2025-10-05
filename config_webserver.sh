#!/bin/bash -ex
yum update -y
yum -y install httpd
systemctl enable httpd
systemctl start httpd
echo '<html><h1>Hello From Your Web Server!</h1></html>' > /var/www/html/index.html
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www