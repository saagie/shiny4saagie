#!/bin/bash
sudo sed -i 's:SAAGIE_BASE_PATH:'"$SAAGIE_BASE_PATH"':g' /etc/nginx/sites-enabled/shiny.conf
nginx && /init_shiny.sh