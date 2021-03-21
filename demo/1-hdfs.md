# Getting started with HDFS

```bash
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

# Some HDFS commands
hdfs dfs -cat hdfs:///demo/countries/countries.csv
```

[List of HDFS commands](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/FileSystemShell.html)
