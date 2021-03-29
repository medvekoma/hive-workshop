# Getting started with HDFS

```bash
# Open shell to Hive Server
docker exec -it cluster_hive-server_1 bash

# content of the local files
ls -la /files

# Create HDFS folders
hdfs dfs -mkdir -p hdfs:///demo/covid/daily
hdfs dfs -mkdir -p hdfs:///demo/covid/vaccinations
hdfs dfs -mkdir -p hdfs:///demo/countries

# List files and folders
hdfs dfs -ls hdfs:///demo/

# Using the name of the HDFS
hdfs dfs -ls hdfs://namenode/demo/

# Copy files from local FS to HDFS
hdfs dfs -copyFromLocal /files/covid_daily.csv hdfs:///demo/covid/daily
hdfs dfs -copyFromLocal /files/country_vaccinations.csv hdfs:///demo/covid/vaccinations
hdfs dfs -copyFromLocal /files/countries.csv hdfs:///demo/countries
```

[List of HDFS commands](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/FileSystemShell.html)
