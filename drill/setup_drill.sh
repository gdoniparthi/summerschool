#! /bin/bash

CONTAINER=`echo -n ${TOKEN} | docker ps -aqf "name=summerschooldb-drill-1"`
echo "Drill container id is ${CONTAINER}"
echo "Copying client-jars to the drill container"
for f in client-jars/*.jar; do docker cp $f ${CONTAINER}:/opt/drill/jars/3rdparty; done
echo "Restarting the drill container"
docker restart ${CONTAINER}

RDBMS=`echo -n ${TOKEN} | docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' summerschooldb-postgres-1`
echo "RDBMS-Storage Plugin Connection String"
echo "{
  \"type\": \"jdbc\",
  \"enabled\": \"true\",
  \"driver\": \"org.postgresql.Driver\",
  \"url\": \"jdbc:postgresql://${RDBMS}:5432/\",
  \"username\": \"postgres\",
  \"password\": \"postgres\"
}"

MONGO=`echo -n ${TOKEN} | docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' summerschooldb-mongodb-1`
echo ""
echo "MONGO-Storage Plugin Connection String"
echo "{
  \"type\": \"mongo\",
  \"connection\": \"mongodb://${MONGO}:27017/\",
  \"pluginOptimizations\": {
    \"supportsProjectPushdown\": true,
    \"supportsFilterPushdown\": true,
    \"supportsAggregatePushdown\": true,
    \"supportsSortPushdown\": true,
    \"supportsUnionPushdown\": true,
    \"supportsLimitPushdown\": true
  },
  \"batchSize\": 100,
  \"enabled\": true,
  \"authMode\": \"SHARED_USER\"
}"
