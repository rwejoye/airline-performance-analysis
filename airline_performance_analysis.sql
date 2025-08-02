-- DATA IMPORT AND TABLE SETUP
-- A custom enum type ('is_low') was defined for the low_cost_carrier column.
-- The 'airline_data' table was manually created to enforce data types and structure.
-- Data was then imported from a CSV file using the pgAdmin import tool.

-- Set the search path to your custom schema
SET search_path TO airline_performance;

-- ENUM type definition 
CREATE TYPE is_low AS ENUM ('Y', 'N');

-- Table creation
CREATE TABLE IF NOT EXISTS airline_data (
    iata_code CHAR(2),
    airline_name VARCHAR,
    region VARCHAR,
    functional_currency CHAR(3),
    ebit_usd BIGINT,
    load_factor NUMERIC(4,3),
    low_cost_carrier airline_performance.is_low,
    airline_age SMALLINT,
    num_routes SMALLINT,
    passenger_yield NUMERIC(4,3),
    ask BIGINT,
    avg_fleet_age NUMERIC(4,2),
    fleet_size SMALLINT,
    aircraft_utilisation NUMERIC(3,1)
);


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
