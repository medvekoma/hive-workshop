## Download tools

```bash
# Download avro-tools
curl https://repo1.maven.org/maven2/org/apache/avro/avro-tools/1.10.2/avro-tools-1.10.2.jar > avro-tools.jar
# Download parquet-tools
curl https://repo1.maven.org/maven2/org/apache/parquet/parquet-tools/1.11.1/parquet-tools-1.11.1.jar > parquet-tools.jar
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