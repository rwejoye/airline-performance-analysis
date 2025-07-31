<h1 align="center">AIRLINE PERFORMANCE ANALYSIS</h1>

PS: Queries are written in **PostgreSQL**.

### Task 1. Identify Key Metrics for Low-Cost vs. Non-Low-Cost Airlines
```sql
-- Compare average EBIT, Load Factor, Number of Routes, Passenger Yield, and Fleet Age by carrier type.

SELECT
	low_cost_carrier,
	ROUND(AVG(ebit_usd), 2) AS avg_ebit_usd,
	ROUND(AVG(load_factor), 2) AS avg_load_factor,
	ROUND(AVG(num_routes), 2) AS avg_num_routes,
	ROUND(AVG(passenger_yield), 2) AS avg_passenger_yield,
	ROUND(AVG(avg_fleet_age), 2) AS avg_fleet_age
FROM airline_data
GROUP BY low_cost_carrier;
```

### Task 2. Regional Performance Analysis of Airlines
```sql
-- Perform comparative analysis amongst regions using average of EBIT, Load Factor, passenger yield, fleet utilisation and airline age.
-- Aircraft utilisation was calculated as ASK * 1.0 / fleet_size to avoid zero results from integer division in PostgreSQL.

-- QUERY 1: To peform the comparative analysis

SELECT
	region,
	ROUND(AVG(ebit_usd), 2) AS avg_ebit_usd,
	ROUND(AVG(load_factor), 2) AS avg_load_factor,
	ROUND(AVG(passenger_yield), 2) AS avg_passenger_yield,
	ROUND((AVG(ask*1.0/fleet_size)), 2) AS avg_aircraft_utilisation,
	ROUND(AVG(airline_age), 2) AS avg_airline_age
FROM airline_data
GROUP BY 1
ORDER BY 2 DESC;

-- QUERY 2: To get no of low cost carriers per region

SELECT
	region,
	SUM(CASE WHEN low_cost_carrier = 'Y' THEN 1 ELSE 0 END) 
		AS low_cost_carriers
FROM airline_data
GROUP BY 1
ORDER BY 2 DESC;
```
