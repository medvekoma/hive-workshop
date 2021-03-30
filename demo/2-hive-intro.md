# Introduction to HIVE

Get familiar with the data in the [cluster/files](../cluster/files) folder.

## Creating Tables

```bash
# Open shell to Hive Server
docker exec -it cluster_hive-server_1 bash

# Start Hive CLI
hive
```

```sql
-- Create external table
CREATE EXTERNAL TABLE covid_daily (
  day date,
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
LOCATION 'hdfs:///demo/covid/daily'
TBLPROPERTIES (
  'skip.header.line.count'='1'
);

-- Test data with queries
SELECT * FROM covid_daily 
WHERE country='Hungary' 
ORDER BY day DESC 
LIMIT 10;
```

## Hive Metastore

Backed by a RDBMS that stores the schemas

```bash
# Quit hive CLI if needed (Ctrl+D)
# Quit Hive Server CLI if needed (Ctrl+D)

# Open shell to the metastore DB
docker exec -it cluster_hive-metastore-postgresql_1 bash

# Open the PostgreSQL command line
psql --username=hive metastore
```

```sql
-- See all tables
\dt

-- query the tables
SELECT * FROM "TBLS";

-- query the table columns
SELECT * FROM "COLUMNS_V2";
```