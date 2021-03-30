# File formats

## Delimited

```sql
CREATE TABLE contacts (
    id INT,
    name STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ",";

INSERT INTO contacts (id, name) VALUES (1, 'Peter');

-- check files in HDFS (hdfs:///user/hive/warehouse)

INSERT INTO contacts
    SELECT 2, 'Maria' UNION ALL
    SELECT 3, 'Anna' UNION ALL
    SELECT 4, 'Yoann';

-- check files again

-- delete a row (what happens?)
DELETE FROM contacts WHERE id = 3;

-- update a row (what happens?)
UPDATE contacts SET name='Johanna' WHERE id = 4;
```

## AVRO

Create a table from another
* CTAS: Create Table As Select

```sql
CREATE TABLE covid_daily_avro 
STORED AS AVRO
AS
SELECT * FROM covid_daily;
```

```bash
# Exit all containers if needed

# Open shell to Hive Server
docker exec -it cluster_hive-server_1 bash

# Download avro-tools
curl https://repo1.maven.org/maven2/org/apache/avro/avro-tools/1.10.2/avro-tools-1.10.2.jar > avro-tools.jar

# List new files
hdfs dfs -ls hdfs:///user/hive/warehouse/covid_daily_avro

# Display schema
hadoop jar avro-tools.jar getschema hdfs:///user/hive/warehouse/covid_daily_avro/000000_0

# Download file
hdfs dfs -copyToLocal hdfs:///user/hive/warehouse/covid_daily_avro/000000_0 covid_daily.avro

# Convert to json
java -jar avro-tools.jar tojson covid_daily.avro  | head
```

Advantages
* Binary format (efficient)
* Has schema
* Schema evolution

## Parquet

Create a parquet table

```sql
CREATE TABLE covid_daily_parquet 
STORED AS PARQUET
AS
SELECT * FROM covid_daily;
```

```bash
# Download parquet-tools
curl https://repo1.maven.org/maven2/org/apache/parquet/parquet-tools/1.11.1/parquet-tools-1.11.1.jar > parquet-tools.jar

# Check files
hdfs dfs -ls hdfs:///user/hive/warehouse/covid_daily_parquet

# Schema
hadoop jar parquet-tools.jar schema hdfs:///user/hive/warehouse/covid_daily_parquet/000000_0

# Content (sample)
hadoop jar parquet-tools.jar head hdfs:///user/hive/warehouse/covid_daily_parquet/000000_0
```

Advantages
* Binary format
* Schema, schema evolution
* Columnar format

```sql
-- Efficient, organized by columns, we only need 3
SELECT day, daily_new_cases 
FROM covid_daily_parquet 
WHERE country = 'Hungary';
```