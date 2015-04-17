#!/usr/bin/env bash

# install postgres
sudo yum install -y http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
sudo yum install -y postgresql94-server postgresql94-contrib
# configure to start on boot
sudo service postgresql-9.4 initdb
sudo service postgresql-9.4 start
sudo chkconfig postgresql-9.4 on

# install redis
sudo yum install -y http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo yum install -y http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sudo yum install -y redis
# configure to start on boot
sudo service redis start
sudo chkconfig redis on

