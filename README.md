Follow the below manual steps to complete the Docker setup

1. Run the following docker command from the "summerschool" folder where there is docker-compose.yml file.

```
docker compose up -d
```

2. Check the containers. Note down the Apache Drill container id. 

```
docker ps
```

3. Copy the client-jar files directly to the Drill container.

```
docker cp drill/client-jars/postgresql-42.6.0.jar  <CONTAINER_ID>:/opt/drill/jars/3rdparty
docker cp drill/client-jars/mongodb-driver-3.12.14.jar <CONTAINER_ID>:/opt/drill/jars/3rdparty
```

4. Restart the drill container

```
docker restart <CONTAINER_ID>
```

5. Once the Drill container is back online, open the UI @ "localhost:8047"

6. Go to the "Storage" tab and enable both "mongo" and "rdbms" storage plugins. You would need the IP addresses of both Postgresql and Mongo containers. You can use following commands

```
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' summerschool-mongodb-1
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' summerschool-postgres-1

or 

docker inspect <CONTAINER_ID>
```


7. Update the "mongo" plugin with the following. You can find the container IP address using "docker inspect <CONTAINER_ID>"

```
{
  "type": "mongo",
  "connection": "mongodb://<Mongo Container IP Address>:27017/",
  "pluginOptimizations": {
    "supportsProjectPushdown": true,
    "supportsFilterPushdown": true,
    "supportsAggregatePushdown": true,
    "supportsSortPushdown": true,
    "supportsUnionPushdown": true,
    "supportsLimitPushdown": true
  },
  "batchSize": 100,
  "enabled": true,
  "authMode": "SHARED_USER"
}
```

8. Update the "rdbms" plugin with the following.

```
{
  "type": "jdbc",
  "enabled": "true",
  "driver": "org.postgresql.Driver",
  "url": "jdbc:postgresql://<Postgres Container IP address>:5432/",
  "username": "postgres",
  "password": "postgres"
}
```

9. On the Drill UI, go to the Queries tab and execute the following test query.

```
select title, plot from rdbms.`movies` where id=19995;
```

10. Try the below Mongo test query. Yes, it is an SQL query!

```
select job, name from mongo.movies.`crew` where movie_id=19995;
``` 

