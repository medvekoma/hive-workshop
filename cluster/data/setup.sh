hdfs dfs -mkdir -p hdfs:///covid/daily
hdfs dfs -mkdir -p hdfs:///covid/vaccinations

hdfs dfs -copyFromLocal /data/covid_daily.csv hdfs:///covid/daily
hdfs dfs -copyFromLocal /data/country_vaccinations.csv hdfs:///covid/vaccinations
