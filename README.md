# ELK-Docker
Docker compose project that setup an ELK stack (Elasticsearch Logstash Kibana).

## About
This project has a docker compose config which allows to setup easily an Elasticsearch, Logstash, Kibana stack.

## Requirements
It is required to create a ```.env``` file to provide your configuration for the variables 
used in the ```docker-compose.yml``` file: 

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
ES_MOUNT_DRIVE=/your/choice/storage/folder
# linux uri way
# windows uri way -> C:/blabla/..

# default index pattern for Kibana, can be anything
ES_FILEBEAT_INDEX_NAME=your-favourite-for-logs

# Filebeat configuration
ES_FILEBEAT_CONFIGURATION=${ES_FOLDER}\config\filebeat.docker.yml
ES_FILEBEAT_LOGS_INPUT=/your/Application/logs/folder
ES_FILEBEAT_INPUT=the_filebeat_input_id
```

## Usage
After configuration variable being set you can go directly on the project with shell and run the command:

```
docker-compose up -d
```
When you finished with it, you can just run:

```
docker-compose down -d
```