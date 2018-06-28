#!/bin/bash

curl -L https://bootstrap.saltstack.com -o install_salt.sh
sh install_salt.sh -M

sed -i '/#master: salt/s/^#//' /etc/salt/minion
sed -i "s/\(master\:\s*\).*$/\1$@/" /etc/salt/minion

curl -fsSL https://get.docker.com/ | sh
mkdir ~/wordpress && cd ~/wordpress
docker run -e MYSQL_ROOT_PASSWORD=test -e MYSQL_DATABASE=wordpress --name wordpressdb -v "$PWD/database":/var/lib/mysql -d mariadb:latest

docker pull wordpress
docker run -e WORDPRESS_DB_PASSWORD=test --name wordpress --link wordpressdb:mysql -p 10.0.0.13:80:80 -v "$PWD/html":/var/www/html -d wordpress
