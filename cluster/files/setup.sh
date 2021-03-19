hdfs dfs -mkdir -p hdfs:///demo/covid/daily
hdfs dfs -mkdir -p hdfs:///demo/covid/vaccinations
hdfs dfs -mkdir -p hdfs:///demo/countries

hdfs dfs -copyFromLocal /files/covid_daily.csv hdfs:///demo/covid/daily
hdfs dfs -copyFromLocal /files/country_vaccinations.csv hdfs:///demo/covid/vaccinations
hdfs dfs -copyFromLocal /files/countries.csv hdfs:///demo/countries
