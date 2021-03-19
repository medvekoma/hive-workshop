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
