# Partitioning

```sql
-- create partitioned table
CREATE TABLE vaccinations_by_country (
  country string,
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
PARTITIONED BY (iso_code string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

-- enable dynamic partitioning
set hive.exec.dynamic.partition=true;    
set hive.exec.dynamic.partition.mode=nonstrict;  

-- insert data (in two steps for memory reasons)
INSERT INTO vaccinations_by_country
PARTITION (iso_code)
SELECT 
    country,
    day,
    total_vaccinations,
    people_vaccinated,
    people_fully_vaccinated,
    daily_vaccinations_raw,
    daily_vaccinations,
    total_vaccinations_per_hundred,
    people_vaccinated_per_hundred,
    people_fully_vaccinated_per_hundred,
    daily_vaccinations_per_million,
    vaccines,
    source_name,
    source_website,
    iso_code
FROM covid_vaccinations
WHERE iso_code < 'M';

INSERT INTO vaccinations_by_country
PARTITION (iso_code)
SELECT 
    country,
    day,
    total_vaccinations,
    people_vaccinated,
    people_fully_vaccinated,
    daily_vaccinations_raw,
    daily_vaccinations,
    total_vaccinations_per_hundred,
    people_vaccinated_per_hundred,
    people_fully_vaccinated_per_hundred,
    daily_vaccinations_per_million,
    vaccines,
    source_name,
    source_website,
    iso_code
FROM covid_vaccinations
WHERE iso_code >= 'M';

-- use the partition (predicate pushdown)
SELECT * 
FROM vaccinations_by_country
WHERE iso_code = 'HUN';
```

```sql
CREATE TABLE vaccinations_by_month (
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
PARTITIONED BY (year int, month int)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

INSERT INTO vaccinations_by_month
PARTITION (year, month)
SELECT
    country,
    iso_code,
    day,
    total_vaccinations,
    people_vaccinated,
    people_fully_vaccinated,
    daily_vaccinations_raw,
    daily_vaccinations,
    total_vaccinations_per_hundred,
    people_vaccinated_per_hundred,
    people_fully_vaccinated_per_hundred,
    daily_vaccinations_per_million,
    vaccines,
    source_name,
    source_website,
    year(day) as year,
    month(day) as month
FROM covid_vaccinations;
```
