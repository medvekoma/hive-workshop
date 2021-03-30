# Serialization and Deserialization (SERDE)

Importing the Country table
* Quotes
* Non-standard decimal separators

```sql
CREATE EXTERNAL TABLE countries (
  country string,
  region string,
  population integer,
  area_sq_mi integer,
  pop_density_per_sq_mi float,
  coastline_per_area float,
  net_migration float,
  infant_mortality_per_1000 float,
  gdp_per_capita float,
  literacy_percentage float,
  phones_per_1000 float,
  arable_percentage float,
  crops_percentage float,
  other_percentage float,
  climate string,
  birthrate float,
  deathrate float,
  agriculture float,
  industry float,
  service float
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:///demo/countries'
TBLPROPERTIES (
  'skip.header.line.count'='1'
);
```

Observe the result in the browser. We have a couple of issues:
* Quotes are stored inside the fields
* Fields containing comma are split (e.g. `Bahamas, The`)
* Comma as decimal separator cannot be processed

## Introducing SERDEs

Custom code for parsing lines

```sql
-- drop existing table
DROP TABLE countries;

-- create new table with SERDE
CREATE EXTERNAL TABLE countries (
  country string,
  region string,
  population integer,
  area_sq_mi integer,
  pop_density_per_sq_mi float,
  coastline_per_area float,
  net_migration float,
  infant_mortality_per_1000 float,
  gdp_per_capita float,
  literacy_percentage float,
  phones_per_1000 float,
  arable_percentage float,
  crops_percentage float,
  other_percentage float,
  climate string,
  birthrate float,
  deathrate float,
  agriculture float,
  industry float,
  service float
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE
LOCATION 'hdfs:///demo/countries'
TBLPROPERTIES (
  'skip.header.line.count'='1'
);

-- Test data
SELECT * FROM countries ORDER BY area_sq_mi DESC;
```

What's wrong? Observe the result in the browser
* All fields are strings :( -- documented issue in OpenCSVSerde

# Creating Views

```sql
CREATE VIEW countries_v AS 
SELECT 
  trim(country) as country,
  trim(region) as region,
  cast(population as integer) as population,
  cast(area_sq_mi as integer) as area_sq_mi,
  cast(regexp_replace(pop_density_per_sq_mi, ',', '.') as float) as pop_density_per_sq_mi,
  cast(regexp_replace(coastline_per_area, ',', '.') as float) as coastline_per_area,
  cast(regexp_replace(net_migration, ',', '.') as float) as net_migration,
  cast(regexp_replace(infant_mortality_per_1000, ',', '.') as float) as infant_mortality_per_1000,
  cast(regexp_replace(gdp_per_capita, ',', '.') as float) as gdp_per_capita,
  cast(regexp_replace(literacy_percentage, ',', '.') as float) as literacy_percentage,
  cast(regexp_replace(phones_per_1000, ',', '.') as float) as phones_per_1000,
  cast(regexp_replace(arable_percentage, ',', '.') as float) as arable_percentage,
  cast(regexp_replace(crops_percentage, ',', '.') as float) as crops_percentage,
  cast(regexp_replace(other_percentage, ',', '.') as float) as other_percentage,
  cast(regexp_replace(climate, ',', '.') as string) as climate,
  cast(regexp_replace(birthrate, ',', '.') as float) as birthrate,
  cast(regexp_replace(deathrate, ',', '.') as float) as deathrate,
  cast(regexp_replace(agriculture, ',', '.') as float) as agriculture,
  cast(regexp_replace(industry, ',', '.') as float) as industry,
  cast(regexp_replace(service, ',', '.') as float) as service
FROM countries;
```

Browse table
* Field types are correct
* Comma in fields is processed correctly
* Numbers are recognized as float

```sql
-- test view
SELECT * FROM countries_v ORDER BY area_sq_mi DESC;

-- calculated fields
SELECT country, birthrate - deathrate AS population_index 
FROM countries_v
ORDER BY population_index DESC;
```

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
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE
LOCATION 'hdfs:///demo/covid/vaccinations'
TBLPROPERTIES (
  'skip.header.line.count'='1'
);

CREATE VIEW covid_vaccinations_v AS
SELECT
  country,
  iso_code,
  cast(day as date) as day,
  cast(total_vaccinations as float) as total_vaccinations,
  cast(people_vaccinated as float) as people_vaccinated,
  cast(people_fully_vaccinated as float) as people_fully_vaccinated,
  cast(daily_vaccinations_raw as float) as daily_vaccinations_raw,
  cast(daily_vaccinations as float) as daily_vaccinations,
  cast(total_vaccinations_per_hundred as float) as total_vaccinations_per_hundred,
  cast(people_vaccinated_per_hundred as float) as people_vaccinated_per_hundred,
  cast(people_fully_vaccinated_per_hundred as float) as people_fully_vaccinated_per_hundred,
  cast(daily_vaccinations_per_million as float) as daily_vaccinations_per_million,
  vaccines,
  source_name,
  source_website
FROM covid_vaccinations;

SELECT country, day, people_fully_vaccinated_per_hundred, vaccines
FROM covid_vaccinations_v
WHERE day='2021-3-28'
ORDER BY people_fully_vaccinated_per_hundred DESC;
```
