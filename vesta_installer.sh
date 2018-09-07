#!/bin/bash

clear

echo "===== Vesta Control Panel Installer for Debian GNU/Linux ====="

echo ""

echo "                               by Wamphyre"

echo ""

echo "Updating System..."

sleep 2

echo ""

apt update && apt upgrade -y 

apt dist-upgrade -y 

apt install -y curl wget htop nano

echo ""

echo "System Updated"

echo ""

curl -O http://vestacp.com/pub/vst-install.sh

echo ; read -p "Set up admin email: " EMAIL;

echo ""

echo ; read -p "Set up Hostname: " HOSTNAME;

echo ""

echo ; read -p "Set up admin password: " PASSWORD;

sleep 1

chmod a+x vst-install.sh 

./vst-install.sh --nginx yes --apache yes --phpfpm no --named yes --remi yes --vsftpd yes --proftpd no --iptables yes --fail2ban yes --quota yes --exim yes --dovecot yes --spamassassin yes --clamav yes --softaculous no --mysql yes --postgresql no --hostname "$HOSTNAME" --email "$EMAIL" --password "$PASSWORD"
