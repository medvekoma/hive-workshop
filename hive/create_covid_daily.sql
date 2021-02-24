CREATE EXTERNAL TABLE covid_daily (
  date1 date,
  country string,
  cumulative_total_cases float,
  daily_new_cases float,
  active_cases float,
  cumulative_total_deaths float,
  daily_new_deaths float
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:///covid/daily'
TBLPROPERTIES (
  'skip.header.line.count'='1'
);
