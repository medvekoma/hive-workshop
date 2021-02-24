hdfs dfs -mkdir -p hdfs:///covid/daily
hdfs dfs -mkdir -p hdfs:///covid/vaccinations

hdfs dfs -copyFromLocal /files/covid_daily.csv hdfs:///covid/daily
hdfs dfs -copyFromLocal /files/country_vaccinations.csv hdfs:///covid/vaccinations
