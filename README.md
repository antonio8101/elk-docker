# ELK-Docker
Docker compose project that setup an ELK stack (Elasticsearch Logstash Kibana).

## About
This project has a docker compose config which allows to setup easily an Elasticsearch, Logstash, Kibana stack.

## Requirements
It is required to create a ```.env``` file to provide your configuration for the variables 
used in the ```elk-docker-compose.yml``` file: 

```
# this project folder
ES_FOLDER=/your/ELK_DocketCompose/folder

# version of the ELK stack containers you want to use
ELASTIC_VERSION=7.0.1

# password for the Elasticsearch server
ES_PASSWORD=changeme

# Elasticsearch mem limit
ES_MEM_LIMIT=2g

# Elasticsearch HVM
ES_JVM_HEAP=1024m

# Elasticsearch server drive to mount. Ensure this drive has permissions. Can set to 777 for time being
ES_MOUNT_DRIVE=/usr/data/

# default index pattern for Kibana, can be anything
ES_DEFAULT_INDEX_PATTERN=metricbeat-*

# Filebeat configuration
ES_FILEBEAT_CONFIGURATION=${ES_FOLDER}\config\filebeat.docker.yml
ES_FILEBEAT_LOGS_INPUT=/your/Application/logs/folder
```