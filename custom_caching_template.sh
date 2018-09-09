#!/bin/bash

mv /usr/local/vesta/data/templates/web/nginx/caching.tpl /usr/local/vesta/data/templates/web/nginx/caching.tpl_OLD

cd /usr/local/vesta/data/templates/web/nginx/

wget https://raw.githubusercontent.com/Wamphyre/GNULinuxTools/master/caching.tpl

cd

echo ""

echo "Custom caching template for VestaCP installed"
