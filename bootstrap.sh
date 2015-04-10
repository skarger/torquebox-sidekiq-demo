#!/usr/bin/env bash

torquebox_user_password=$1

sudo groupadd torquebox

sudo useradd -d /home/torquebox -m -g torquebox -s /bin/bash torquebox
echo $torquebox_user_password | sudo passwd torquebox --stdin

mkdir /opt/torquebox
sudo chown torquebox:torquebox /opt/torquebox

sudo yum -y install zip unzip

sudo su torquebox
unzip /vagrant/torquebox-dist-3.1.1-bin.zip -d /opt/torquebox/
cd /opt/torquebox
ln -s torquebox-dist-3.1.1 current

echo "export TORQUEBOX_HOME=/opt/torquebox/current
export JBOSS_HOME=$TORQUEBOX_HOME/jboss
export JRUBY_HOME=$TORQUEBOX_HOME/jruby
export PATH=$JRUBY_HOME/bin:$PATH" > /etc/profile.d/torquebox.sh


