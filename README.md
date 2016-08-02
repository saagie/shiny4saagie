Template to build on top of this image:

```
FROM shiny4saagie

# Install R packages required by your Shiny app
RUN R -e 'install.packages(c("DT", "magrittr"), repos="http://cran.rstudio.com")'

# Copy your Shiny app to /srv/shiny-server/myapp
COPY myapp /srv/shiny-server/myapp

# Launch Shiny Server
CMD ["/usr/bin/shiny-server.sh"]
```

To use the image you built, push it to your public Dockerhub repo, then pull it from Saagie
Or build it in a private repo, directly from Jenkins on the platform

Runs on port 3838

