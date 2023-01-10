#!/bin/bash
export PATH=$PATH:/usr/bin
sleep 1m
# install nginx
sudo apt update
sleep 1m
sudo apt install -y nginx
rm index.nginx-debian.html
cat index.html > /var/www/html/index.html
exit 0