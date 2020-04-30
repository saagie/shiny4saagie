## Start with the official rocker image (lightweight Debian)
FROM rocker/shiny:3.6.3

## APP TEST ## 
# Install R packages required by your Shiny app
RUN R -e 'install.packages(c("DT", "magrittr"), repos="http://cloud.r-project.org")'
# Copy your Shiny app to /srv/shiny-server/myapp
COPY myapp /srv/shiny-server/myapp

# INSTALLATION DES PRERREQUIS
RUN apt-get update && apt-get install -y  \
    nginx \
    openssl
# CONFIGURATION NGINX
COPY server.conf /etc/nginx/sites-enabled/shiny.conf
RUN rm /etc/nginx/sites-enabled/default

# EXPOSITION DE PORT & LANCEMENT DE CONTENEUR 
EXPOSE 80
ADD entrypoint.sh /entrypoint.sh
ADD init_shiny.sh /init_shiny.sh
ENTRYPOINT ["/entrypoint.sh"]

