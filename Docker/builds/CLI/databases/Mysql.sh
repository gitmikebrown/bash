################################################################################################
####   MySQL container
################################################################################################
####
####    Link: https://www.howtogeek.com/devops/how-to-run-mysql-in-a-docker-container/#connecting-to-mysql
####    Notes: Helpful
####    
####    Link: https://hub.docker.com/_/mysql
####    Notes: 
####
################################################################################################

 
################################################################################################
####   Access the MySQL CLI
################################################################################################


#root
sudo docker exec -it c-mysql-1 mysql -p

#with user
sudo docker exec -it c-mysql-1 mysql -p --user brown

#See all users
#mysql> SELECT User,Host FROM mysql.user;

#see all mysql.user field options
#mysql> desc mysql.user;

#See who is logged in
#mysql> SELECT user, host,db, command FROM information_schema.processlist;

################################################################################################
####   UP - Build container
################################################################################################

root_password=green
user_name=brown1
user_password=green3
#Mysql Latest
sudo docker run --name c-mysql-1 \
-p 3306:3306 \
-v v-mysql-1:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=$root_password \
-e MYSQL_ONETIME_PASSWORD=true \
-e MYSQL_USER=$user_name \
-e MYSQL_PASSWORD=$user_password \
-e MYSQL_DATABASE=laravel \
-d mysql



################################################################################################
####   DOWN - destroy container
################################################################################################

sudo docker stop c-mysql-1;
sudo docker container rm c-mysql-1
sudo docker volume rm v-mysql-1;
sudo docker image rm mysql;



################################################################################################
####   View the logs
################################################################################################

sudo docker logs c-mysql-1


################################################################################################
####   View all of the config file options
################################################################################################

sudo docker run -it --rm mysql --verbose --help
