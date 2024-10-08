#!/bin/bash
# File: 
# Author: Michael Brown
# Date: 
# Description: 

################################################################################################
####   helpful links
################################################################################################
####
####    Link:https://stackoverflow.com/questions/57582453/is-there-a-suggested-list-of-values-for-laravels-app-env-variable-found-in-the
####    Notes: Link provides APP_ENV options.  Options are: local/development/staging/production
####    
####    Link:https://panjeh.medium.com/laravel-app-env-local-app-env-production-difference-aa9662ac81d0
####    Notes: Link provides a good APP_ENV explanation.
####
################################################################################################



################################################################################################
####   Postgress
################################################################################################

#https://hub.docker.com/_/postgres


#Latest
docker run --name my-postgres-1 \
-p 5432:5432 \
-e POSTGRES_PASSWORD=mysecretpassword \
-d postgres


#V16.3
docker run --name postgres-1 \
-p 5432:5432 \
-e POSTGRES_PASSWORD=green \
-d postgres:16.3