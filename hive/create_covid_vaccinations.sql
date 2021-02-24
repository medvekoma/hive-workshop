CREATE EXTERNAL TABLE covid_vaccinations (
  country string,
  iso_code string,
  date1 date,
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
LOCATION 'hdfs:///covid/vaccinations'
TBLPROPERTIES (
  'skip.header.line.count'='1'
);
