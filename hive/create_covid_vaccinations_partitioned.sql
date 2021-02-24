CREATE TABLE covid_vaccinations_by_country (
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
PARTITIONED BY (country string);

set hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE covid_vaccinations_by_country PARTITION(country)
SELECT iso_code,date1,total_vaccinations,people_vaccinated,people_fully_vaccinated,daily_vaccinations_raw,daily_vaccinations,total_vaccinations_per_hundred,people_vaccinated_per_hundred,people_fully_vaccinated_per_hundred,daily_vaccinations_per_million,vaccines,source_name,source_website,country from  covid_vaccinations;