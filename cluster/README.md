# docker-hadoop-hive-parquet

Forked from https://github.com/tech4242/docker-hadoop-hive-parquet

This project will showcase how to spin up a Hadoop cluster with Hive in order to run SQL queries on Parquet files. Images for the nodes are based on https://hub.docker.com/u/bde2020 base images.

All of this makes more sense if you follow the link in the repository to the article on Medium :)

## Useful commands

```bash
# Create cluster
docker-compose up -d

# Open command line on Hive Server
docker exec -it cluster_hive-server_1 bash

# Terminate cluster
docker-compose down
```

## Test data

The [files](files) folder contains test data. This folder is mapped as a volume to the 
docker container `cluster_hive-server_1`, so all its files will be available in the
`/files` folder inside the container.