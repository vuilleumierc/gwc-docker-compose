FROM jetty:10-jre11 as builder

ENV GEOSERVER_VERSION 2.20
ENV GEOSERVER_MINOR_VERSION 7
ENV XMS=1536M XMX=8G

USER root

# the fonts are located in non-free
RUN sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list
RUN apt-get update \
    # accept the fonts EULA without the ncurses GUI
    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
    && apt-get install -y ttf-mscorefonts-installer unzip\
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# libjpeg-turbo is different from turboJpeg
RUN wget https://sourceforge.net/projects/libjpeg-turbo/files/2.1.2/libjpeg-turbo-official_2.1.2_amd64.deb && \
    dpkg -i libjpeg-turbo-official_2.1.2_amd64.deb && \
    rm libjpeg-turbo-official_2.1.2_amd64.deb

# create dirs
RUN install -o jetty -g jetty -d /tmp/geoserver /mnt/geoserver_datadir /mnt/geoserver_geodata /mnt/geoserver_tiles
VOLUME [ "/mnt/geoserver_datadir", "/mnt/geoserver_geodata", "/mnt/geoserver_tiles", "/tmp" ]

USER jetty

RUN sed -i 's/threads.max=200/threads.max=50/g' $JETTY_BASE/start.d/server.ini

# Install geoserver
RUN curl -L https://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}.${GEOSERVER_MINOR_VERSION}/geoserver-${GEOSERVER_VERSION}.${GEOSERVER_MINOR_VERSION}-war.zip/download > /tmp/geoserver.zip && \
    unzip -o /tmp/geoserver.zip -d /tmp/geoserver && \
    unzip -o /tmp/geoserver/geoserver.war -d $JETTY_BASE/webapps/geoserver && \
    rm -r /tmp/geoserver*

# JVM var java.library.path will be based on this env var. so GS will search native libs there.
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/opt/libjpeg-turbo/lib64/:$JETTY_HOME/lib/ext/"

# the servlets jetty module contains CORS filters
RUN java -jar "$JETTY_HOME/start.jar" --add-module=servlets
