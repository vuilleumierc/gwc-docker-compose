.PHONY: run

run:
	docker-compose up -d postgres geoserver-jetty geoserver-tomcat
	sleep 2
	GEOSERVER_URL='http://localhost:8082/' ./config/config_geoserver.sh
	GEOSERVER_URL='http://localhost:8081/geoserver/' ./config/config_geoserver.sh
	sleep 2
	docker-compose up -d

.PHONY: clean-gwc-cache

clean-gwc-cache:
	curl 'http://localhost:8083/gwc/rest/masstruncate' -v -u admin:geoserver --data-raw '%3CtruncateAll%3E=%3C%2FtruncateAll%3E'
