-- DATA IMPORT AND TABLE SETUP
-- The 'airline_data' table was created manually using a CREATE TABLE statement 
-- to define column data types and structure before importing the CSV data.
-- Data was imported into PostgreSQL using the pgAdmin import tool.

-- Task 1: Identify Key Metrics for Low-Cost vs. Non-Low-Cost Airlines
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


-- Task 2: Regional Performance Analysis of Airlines
-- QUERY 1: Comparative analysis among regions using avg EBIT, Load Factor, Yield, Utilisation & Airline Age
SELECT
    region,
    ROUND(AVG(ebit_usd), 2) AS avg_ebit_usd,
    ROUND(AVG(load_factor), 2) AS avg_load_factor,
    ROUND(AVG(passenger_yield), 2) AS avg_passenger_yield,
    ROUND(AVG(ask * 1.0 / fleet_size), 2) AS avg_aircraft_utilisation,
    ROUND(AVG(airline_age), 2) AS avg_airline_age
FROM airline_data
GROUP BY region
ORDER BY avg_ebit_usd DESC;

-- QUERY 2: Number of low-cost carriers per region
SELECT
    region,
    SUM(CASE WHEN low_cost_carrier = 'Y' THEN 1 ELSE 0 END) AS low_cost_carriers
FROM airline_data
GROUP BY region
ORDER BY low_cost_carriers DESC;
