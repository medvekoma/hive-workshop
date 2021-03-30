# Joins

## Types of joins

![Join](img/join.png)

## Join two tables

Display top countries by new Covid cases

```sql
SELECT d.country, d.daily_new_cases / c.population * 1000000 as new_cases_per_million
FROM covid_daily d JOIN countries_v c ON d.country = c.country
WHERE day = '2021-3-29'
ORDER BY new_cases_per_million DESC
LIMIT 10;
```

## Importance of data cleaning

Records with mismatched keys

```sql
SELECT d.country, c.country
FROM covid_daily d FULL JOIN countries_v c on d.country = c.country
WHERE c.country IS NULL OR d.country IS NULL
GROUP BY d.country, c.country;
```
