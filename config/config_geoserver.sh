#/bin/bash

# Script to initialize geoserver config on composition start-up using the REST API

# Create a workspace
until curl -v -u admin:geoserver -POST -H "Content-type: text/xml"  -d "<workspace><name>geo</name></workspace>"  $GEOSERVER_URL"rest/workspaces"
do
    sleep 2
done

# Add postgis datastore
until curl -v -u admin:geoserver -XPOST -T "config/datastore/datastore_postgis.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/workspaces/geo/datastores"
do
    sleep 2
done

# Add postgis layers
until curl -v -u admin:geoserver -XPOST -T "config/layers/layer_location.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/workspaces/geo/featuretypes"
do
    sleep 2
done

# Change point style
until curl -v -u admin:geoserver -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -T "config/styles/point.sld" $GEOSERVER_URL"rest/styles/point"
do
    sleep 2
done
