#!/usr/bin/env bash

# parse arguments
torquebox_user_password=$1
deploy_ssh_public_key=$2

# install package dependencies
# for unzipping torquebox distribution from /vagrant
sudo yum -y install zip unzip
# for torquebox and jruby
sudo yum -y install java-1.7.0-openjdk-devel.x86_64
# for capistrano
sudo yum -y install git.x86_64

# set up deploy user for capistrano
# reference: http://capistranorb.com/documentation/getting-started/authentication-and-authorisation/
sudo adduser deploy
sudo passwd -l deploy
sudo su - deploy
cd ~
mkdir .ssh
echo "$deploy_ssh_public_key" >> .ssh/authorized_keys
chmod 700 .ssh
chmod 600 .ssh/authorized_keys
exit # back to vagrant user

# set up torquebox user and group
sudo groupadd torquebox
sudo useradd -d /home/torquebox -m -g torquebox -s /bin/bash torquebox
echo $torquebox_user_password | sudo passwd torquebox --stdin

# install torquebox
mkdir /opt/torquebox
sudo chown torquebox:torquebox /opt/torquebox
sudo su torquebox
unzip /vagrant/torquebox-dist-3.1.1-bin.zip -d /opt/torquebox/
cd /opt/torquebox
ln -s torquebox-dist-3.1.1 current

echo "export TORQUEBOX_HOME=/opt/torquebox/current
export JBOSS_HOME=$TORQUEBOX_HOME/jboss
export JRUBY_HOME=$TORQUEBOX_HOME/jruby
export PATH=$JRUBY_HOME/bin:$PATH" > /etc/profile.d/torquebox.sh
exit # back to vagrant user

