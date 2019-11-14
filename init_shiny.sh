#!/bin/sh
mkdir -p /var/log/shiny-server
chown shiny.shiny /var/log/shiny-server
Rscript -e 'library(methods); shiny::runApp("/srv/shiny-server/myapp", 3838)'