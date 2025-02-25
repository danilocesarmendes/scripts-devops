#!/bin/bash

# Instalar mysql 

sudo yum update -y 

# This will list all the packages of MariaDB.
yum list mariadb* 

#this will successfully install Maria DB.
sudo yum install mariadb105-server.x86_64

sudo systemctl enable mariadb

sudo systemctl start mariadb

