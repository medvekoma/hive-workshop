# Joins

```sql
SELECT d.country, d.daily_new_cases / c.population * 1000000 as new_cases_per_million
FROM covid_daily d JOIN countries_v c ON d.country = c.country
WHERE day = '2021-3-18'
ORDER BY new_cases_per_million DESC
LIMIT 10
```

## Importance of data cleaning

```sql
SELECT d.country
FROM covid_daily d LEFT JOIN countries_v c on d.country = c.country
WHERE c.country IS NULL
GROUP BY d.country;
```
