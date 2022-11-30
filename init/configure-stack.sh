#!/bin/bash


# Wait for Elasticsearch to start up before doing anything.
until curl -u elastic:changeme -s http://elasticsearch:9200/_cat/health -o /dev/null; do
    echo Waiting for Elasticsearch...
    sleep 1
done

# Waiting for Kibana to start up before doing anything.
echo Waiting for Kibana...
until curl -f -LI http://kibana:5601/api/rollup/indices; do
    echo Waiting for Kibana...
    sleep 1
done

echo Creating index-pattern on Kibana...
curl -X POST http://kibana:5601/api/saved_objects/index-pattern \
  -H 'kbn-xsrf: true' \
  -H 'Content-Type: application/json' \
  -d "{\"attributes\": { \"title\": \"${ES_FILEBEAT_INDEX_NAME}*\", \"timeFieldName\": \"@timestamp\" }}";

echo Setup default index-pattern on Kibana...
curl -X POST http://localhost:5601/api/kibana/settings \
  -H 'kbn-xsrf: true' \
  -H 'Content-Type: application/json' \
  -d "{\"changes\":{\"defaultIndex\":\"${ES_FILEBEAT_INDEX_NAME}-*\"}}"

echo Increase the max_analyzed_offset for big messages...
curl -X PUT "http://elasticsearch:9200/${ES_FILEBEAT_INDEX_NAME}/_settings"  \
  -H 'Content-Type: application/json' \
  -d "{ \"index\" : { \"highlight.max_analyzed_offset\" : ${ES_MAX_ANALYZED_OFFSET}}}"


#echo Setup mapping on Elastic...
# curl -s -XPUT http://elasticsearch:5601/_template/template_logs?include_type_name=true \
#     -H "Content-Type: application/json"  \
#     -d ''
