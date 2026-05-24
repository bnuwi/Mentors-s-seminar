DROP TABLE IF EXISTS pump_failures CASCADE;
DROP TABLE IF EXISTS pump_sensors CASCADE;
DROP TABLE IF EXISTS pumps CASCADE;
DROP TABLE IF EXISTS well_targets CASCADE;
DROP TABLE IF EXISTS well_telemetry CASCADE;
DROP TABLE IF EXISTS production CASCADE;
DROP TABLE IF EXISTS wells CASCADE;
DROP TABLE IF EXISTS deliveries CASCADE;
DROP TABLE IF EXISTS vehicles CASCADE;
DROP TABLE IF EXISTS drivers CASCADE;

CREATE TABLE wells (
    well_id INT PRIMARY KEY,
    name TEXT NOT NULL,
    field_name TEXT,
    region TEXT,
    start_date DATE,
    operator TEXT,
    status TEXT
);

CREATE TABLE production (
    production_id SERIAL PRIMARY KEY,
    well_id INT REFERENCES wells(well_id),
    date DATE NOT NULL,
    oil_ton NUMERIC(10,2),
    gas_m3 NUMERIC(12,2),
    water_m3 NUMERIC(12,2),
    energy_kwh NUMERIC(12,2),
    downtime_hours NUMERIC(8,2),
    temperature NUMERIC(8,2),
    pressure NUMERIC(8,2)
);

CREATE TABLE well_telemetry (
    record_id SERIAL PRIMARY KEY,
    well_id INT REFERENCES wells(well_id),
    timestamp TIMESTAMP NOT NULL,
    pump_speed_rpm NUMERIC(8,2),
    pump_current NUMERIC(8,2),
    pressure_in NUMERIC(8,2),
    pressure_out NUMERIC(8,2),
    temperature NUMERIC(8,2),
    vibration NUMERIC(8,2),
    oil_flow_rate NUMERIC(8,2)
);

CREATE TABLE well_targets (
    target_id SERIAL PRIMARY KEY,
    well_id INT REFERENCES wells(well_id),
    date DATE NOT NULL,
    daily_oil_ton NUMERIC(10,2)
);

CREATE TABLE pumps (
    pump_id INT PRIMARY KEY,
    well_id INT REFERENCES wells(well_id),
    type TEXT,
    install_date DATE,
    manufacturer TEXT,
    model TEXT
);

CREATE TABLE pump_sensors (
    record_id SERIAL PRIMARY KEY,
    pump_id INT REFERENCES pumps(pump_id),
    timestamp TIMESTAMP NOT NULL,
    temperature NUMERIC(8,2),
    vibration NUMERIC(8,2),
    current NUMERIC(8,2),
    rpm NUMERIC(8,2),
    pressure NUMERIC(8,2)
);

CREATE TABLE pump_failures (
    failure_id SERIAL PRIMARY KEY,
    pump_id INT REFERENCES pumps(pump_id),
    failure_date TIMESTAMP NOT NULL,
    failure_type TEXT,
    downtime_hours NUMERIC(8,2)
);

CREATE TABLE drivers (
    driver_id INT PRIMARY KEY,
    name TEXT NOT NULL,
    experience_years INT,
    region TEXT
);

CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY,
    plate_number TEXT NOT NULL,
    capacity_ton NUMERIC(10,2),
    fuel_type TEXT
);

CREATE TABLE deliveries (
    delivery_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    source TEXT,
    destination TEXT,
    product_type TEXT,
    volume_ton NUMERIC(10,2),
    cost_usd NUMERIC(12,2),
    delay_hours NUMERIC(8,2),
    distance_km NUMERIC(10,2),
    weather_conditions TEXT,
    driver_id INT REFERENCES drivers(driver_id),
    vehicle_id INT REFERENCES vehicles(vehicle_id)
);