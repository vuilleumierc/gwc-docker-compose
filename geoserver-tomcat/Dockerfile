FROM tomcat:9-jre11 as builder

ENV GEOSERVER_VERSION 2.20
ENV GEOSERVER_MINOR_VERSION 7

RUN apt-get update \
    && apt-get install -y unzip\
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/geoserver /mnt/geoserver_datadir /mnt/geoserver_geodata /mnt/geoserver_tiles

# Install geoserver
RUN curl -L https://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}.${GEOSERVER_MINOR_VERSION}/geoserver-${GEOSERVER_VERSION}.${GEOSERVER_MINOR_VERSION}-war.zip/download > /tmp/geoserver.zip && \
    unzip -o /tmp/geoserver.zip -d /tmp/geoserver && \
    unzip -o /tmp/geoserver/geoserver.war -d $CATALINA_HOME/webapps/ROOT && \
    rm -r /tmp/*

VOLUME [ "/mnt/geoserver_datadir", "/mnt/geoserver_geodata", "/mnt/geoserver_tiles", "/tmp" ]

# The officials APT turbojpeg packages libjpeg62-turbo libturbojpeg0 are not supported by geoserver (?)
RUN wget https://sourceforge.net/projects/libjpeg-turbo/files/2.1.2/libjpeg-turbo-official_2.1.2_amd64.deb && \
    dpkg -i libjpeg-turbo-official_2.1.2_amd64.deb && \
    rm libjpeg-turbo-official_2.1.2_amd64.deb
# JVM var java.library.path will be based on this env var. so GS will search native libs there.
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/opt/libjpeg-turbo/lib64/"
