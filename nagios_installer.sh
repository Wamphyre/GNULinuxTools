#!/bin/bash

echo "----- NAGIOS INSTALLER for VestaCP -----"

echo ""

echo "================== By Wamphyre"

echo ""

sleep 2

useradd nagios

groupadd nagcmd

usermod -a -G nagcmd nagios

usermod -a -G nagcmd www-data

wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.2.tar.gz

tar -xvf nagios-4.4.2.tar.gz

cd nagios-4.4.2

./configure --with-nagios-group=nagios --with-command-group=nagcmd --with-httpd_conf=/etc/apache2/sites-enabled/
make all

make install

make install-init

make install-config

make install-commandmode

make install-webconf

cd ..

wget https://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz

tar -zxvf nagios-plugins-2.2.1.tar.gz

cd  nagios-plugins-2.2.1/

./configure --with-nagios-user=nagios --with-nagios-group=nagios

make

make install

cd ..

a2enmod cgi

service apache2 restart

echo ""

echo ; read -p "Need admin email to Nagios contact: " CORREO

echo ""

mv /usr/local/nagios/etc/objects/contacts.cfg /usr/local/nagios/etc/objects/contacts.cfg.backup

echo 'define contact {

    contact_name            nagiosadmin             ; Short name of user
    use                     generic-contact         ; Inherit default values from generic-contact template (defined above)
    alias                   Nagios Admin            ; Full name of user
    email                   "$CORREO" ; <<***** CHANGE THIS TO YOUR EMAIL ADDRESS ******
}

define contactgroup {

    contactgroup_name       admins
    alias                   Nagios Administrators
    members                 nagiosadmin
}' >> /usr/local/nagios/etc/objects/contacts.cfg

echo "Setting password to nagiosadmin user panel interface"

echo ""

htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

echo ""

/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

systemctl enable nagios

/etc/init.d/nagios start

echo ""

echo "Nagios UP and Running"
