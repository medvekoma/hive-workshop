# HUE

User interface to Hadoop

http://localhost:8888 (See exposed port in [docker-compose.yml](../cluster/docker-compose.yml))

## Files - HDFS

HDFS file browser

## Tables - Hive

* Browse existing Hive tables
* Run Hive queries (code completion)

```sql
-- Create new table in HUE
CREATE EXTERNAL TABLE covid_vaccinations (
  country string,
  iso_code string,
  day date,
  total_vaccinations float,
  people_vaccinated float,
  people_fully_vaccinated float,
  daily_vaccinations_raw float,
  daily_vaccinations float,
  total_vaccinations_per_hundred float,
  people_vaccinated_per_hundred float,
  people_fully_vaccinated_per_hundred float,
  daily_vaccinations_per_million float,
  vaccines string,
  source_name string,
  source_website string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:///demo/covid/vaccinations'
TBLPROPERTIES (
  'skip.header.line.count'='1'
);
```

* See new table in the browser
* Open in browser, sample
* Build a query with autocomplete
```sql
SELECT country, SUM(total_vaccinations_per_hundred) AS vaccinations_per_100k FROM covid_vaccinations
GROUP BY country
ORDER BY vaccinations_per_100k DESC
```
