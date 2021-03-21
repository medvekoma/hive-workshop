# Partitioning

```sql
-- enable dynamic partitioning
set hive.exec.dynamic.partition=true;    
set hive.exec.dynamic.partition.mode=nonstrict;  

-- create partitioned table
CREATE TABLE countries_by_region (
  country string,
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
PARTITIONED BY (region string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

-- populate partitioned table
INSERT INTO countries_by_region
PARTITION (region)
SELECT
  country,
  population,
  area_sq_mi,
  pop_density_per_sq_mi,
  coastline_per_area,
  net_migration,
  infant_mortality_per_1000,
  gdp_per_capita,
  literacy_percentage,
  phones_per_1000,
  arable_percentage,
  crops_percentage,
  other_percentage,
  climate,
  birthrate,
  deathrate,
  agriculture,
  industry,
  service,
  region
FROM countries;
```
