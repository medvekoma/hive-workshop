CREATE VIEW countries_v AS 
SELECT 
  country,
  region,
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