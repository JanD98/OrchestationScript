#!/bin/bash

curl -L https://bootstrap.saltstack.com -o install_salt.sh
sh install_salt.sh -M

sed -i '/master: salt/s/^#//' etc/salt/minion
sed -i 's/\(master\:\s*\).*$/\1$1/' /etc/salt/minion

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-cache policy docker-ce
apt-get install -y docker-ce

curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose -f wordpress.yml up
