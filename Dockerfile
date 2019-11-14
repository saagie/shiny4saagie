FROM cardcorp/r-java

# INSTALLATION DES PRERREQUIS
RUN apt-get update && apt-get install -y -t unstable \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev/unstable \
    libxt-dev \
    curl \
    nginx \
    openssl

# INSTALLATION DE IMPALA JDBC => REQUIRE TO DOWNLOAD IMPALA JDBC FIRST
# RUN mkdir /usr/lib/impala && mkdir /usr/lib/impala/lib
# COPY ./impala_jdbc_2.6.4.1005.zip /usr/lib/impala/lib
# RUN cd /usr/lib/impala/lib && unzip -j impala_jdbc_2.6.4.1005.zip && rm impala_jdbc_2.6.4.1005.zip
# RUN R -e 'install.packages(c("RJDBC", "RImpala"), repos = "http://cran.rstudio.com")'

# INSTALLATION DE SHINY
RUN wget --no-verbose "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.12.933-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f ss-latest.deb && \
    R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cran.rstudio.com/')" && \
    cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/

## APP TEST ## 
# Install R packages required by your Shiny app
RUN R -e 'install.packages(c("DT", "magrittr"), repos="http://cloud.r-project.org")'
# Copy your Shiny app to /srv/shiny-server/myapp
COPY myapp /srv/shiny-server/myapp

# CONFIGURATION NGINX
COPY server.conf /etc/nginx/sites-enabled/shiny.conf
RUN rm /etc/nginx/sites-enabled/default

# EXPOSITION DE PORT & LANCEMENT DE CONTENEUR 
EXPOSE 80
ADD entrypoint.sh /entrypoint.sh
ADD init_shiny.sh /init_shiny.sh
ENTRYPOINT ["/entrypoint.sh"]

