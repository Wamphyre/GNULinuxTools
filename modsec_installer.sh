#!/bin/bash

clear

echo "ModSecurity Installer"

echo "====================="

echo "==========By Wamphyre"

echo ""

sleep 2

apt-get install -y libapache2-modsecurity

mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf

sed -i 's/SecRuleEngine off/SecRuleEngine on/g' "/etc/modsecurity/modsecurity.conf"

rm -rf /usr/share/modsecurity-crs

git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git /usr/share/modsecurity-crs

cd /usr/share/modsecurity-crs 

mv crs-setup.conf.example crs-setup.conf

rm -rf /etc/apache2/mods-enabled/security2.conf

touch /etc/apache2/mods-enabled/security2.conf

echo '<IfModule security2_module> 
     SecDataDir /var/cache/modsecurity 
     IncludeOptional /etc/modsecurity/*.conf 
     IncludeOptional "/usr/share/modsecurity-crs/*.conf 
     IncludeOptional "/usr/share/modsecurity-crs/rules/*.conf 
 </IfModule>' >> /etc/apache2/mods-enabled/security2.conf

systemctl restart apache2

systemctl restart nginx

echo ""

echo "Instalación finalizada"

echo ""

echo "Testeando ModSec"

echo ""

echo "Test 1 - Ataque XSS"

HOST=$(hostname)

curl 'http://$HOST/?q="><script>alert(1)</script>'

echo ""

echo "Si carga un 403, es correcto"

echo ""

echo "Test 2 - Inyección SQL"

curl "http://$HOST/?q='1 OR 1=1"

echo ""

echo "Si carga otro 403, es correcto"

echo ""

echo "Finalizado"
