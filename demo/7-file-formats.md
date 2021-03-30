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

```bash
# Download avro-tools
curl https://repo1.maven.org/maven2/org/apache/avro/avro-tools/1.10.2/avro-tools-1.10.2.jar > avro-tools.jar
```

```sql
CREATE TABLE covid_daily_avro 
STORED AS AVRO
AS
SELECT * FROM covid_daily;
```

```bash

hdfs dfs -ls hdfs:///user/hive/warehouse/covid_daily_avro

hadoop jar avro-tools.jar getschema hdfs:///user/hive/warehouse/covid_daily_avro/000000_0

hdfs dfs -copyToLocal hdfs:///user/hive/warehouse/covid_daily_avro/000000_0 covid_daily.avro

java -jar avro-tools.jar tojson covid_daily.avro  | head
```

## Parquet

```bash
# Download parquet-tools
curl https://repo1.maven.org/maven2/org/apache/parquet/parquet-tools/1.11.1/parquet-tools-1.11.1.jar > parquet-tools.jar
```

```sql
CREATE TABLE covid_daily_parquet 
STORED AS PARQUET
AS
SELECT * FROM covid_daily;
```

```bash
hdfs dfs -ls hdfs:///user/hive/warehouse/covid_daily_parquet

hadoop jar parquet-tools.jar schema hdfs:///user/hive/warehouse/covid_daily_parquet/000000_0

hadoop jar parquet-tools.jar head hdfs:///user/hive/warehouse/covid_daily_parquet/000000_0
```
