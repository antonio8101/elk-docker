#!/bin/bash


# Wait for Elasticsearch to start up before doing anything.
#until curl -u admin:admin -s https://opensearch:9200/_cat/health -o /dev/null; do
#    echo Waiting for Opensearch...
#    sleep 1
#done

echo Creating index-pattern on Dashboard...
curl -X POST http://dashboard:5601/api/saved_objects/index-pattern \
  -H 'kbn-xsrf: true' \
  -H 'Content-Type: application/json' \
  -d "{\"attributes\": { \"title\": \"${ES_FILEBEAT_INDEX_NAME}*\", \"timeFieldName\": \"@timestamp\" }}";

#echo Setup default index-pattern on Kibana...
#curl -X POST http://dashboard:5601/api/kibana/settings \
#  -H 'kbn-xsrf: true' \
#  -H 'Content-Type: application/json' \
#  -d "{\"changes\":{\"defaultIndex\":\"${ES_FILEBEAT_INDEX_NAME}-*\"}}"

echo Increase the max_analyzed_offset for big messages...
curl -X PUT "https://admin:admin@opensearch:9200/${ES_FILEBEAT_INDEX_NAME}/_settings"  \
  -H 'Content-Type: application/json' \
  -d "{ \"index\" : { \"highlight.max_analyzed_offset\" : ${ES_MAX_ANALYZED_OFFSET}}}"


sleep 5m