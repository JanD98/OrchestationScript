#!/bin/bash

curl -L https://bootstrap.saltstack.com -o install_salt.sh
sh install_salt.sh -M

sed -i 's/\(master\:\s*\).*$/\1$1/' /etc/salt/minion

