FROM openanalytics/r-base

MAINTAINER rohitsrmuniv@gmail.com

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl1.0.0 \
	libxml2-dev 
	
RUN apt-get update -qyy

# basic shiny functionality
RUN R -e "install.packages(c('shiny', 'shinycssloaders', 'dplyr', 'jpeg', 'pracma', 'data.table', 'DT', 'shinyjs', 'shinyBS'), repos='http://cran.rstudio.com/')"

# copy the app to the image
RUN mkdir /root/Shiny
COPY Shiny /root/Shiny

COPY Rprofile.site /usr/lib/R/etc/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/Shiny')"]