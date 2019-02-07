FROM r-base:latest

MAINTAINER VP Nagraj "vpnagraj@virginia.edu"

# Install dependencies and Download and install shiny server
RUN apt-get update && apt-get install -y -t unstable \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libsodium-dev \
    libssl-dev \
    libxml2-dev \
    r-cran-rmysql \
    libcurl4-gnutls-dev \
    libcairo2-dev/unstable \
    git \
    libxt-dev && \
    wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    R -e "install.packages(c('shiny','rmarkdown','devtools'), repos='https://cran.rstudio.com/')" && \
    cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/ && \
    rm -rf /var/lib/apt/lists/*

# install consultr package to get dependencies
RUN R -e "devtools::install_github('clayford/consultr')"

# move conf and setup files and clear out shiny server demo apps
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
COPY shiny-server.sh /usr/bin/shiny-server.sh
RUN rm -rf /srv/shiny-server/*

# get the app code
RUN git clone https://github.com/clayford/consultr
RUN cp -rf consultr/inst/shiny-apps/*  /srv/shiny-server/.

# get index.html setup
COPY index.R /srv/shiny-server/index.R
RUN Rscript /srv/shiny-server/index.R

# run the server setup script
CMD ["/usr/bin/shiny-server.sh"]
