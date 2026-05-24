INSERT INTO pump_sensors (pump_id, timestamp, temperature, vibration, current, rpm, pressure)
SELECT
    1 as pump_id,
    gs as timestamp,
    73.0 + (random() * 4 - 2) as temperature,
    2.2 + (random() * 0.6 - 0.3) as vibration,
    58.5 + (random() * 1 - 0.5) as current,
    1472 + (random() * 10 - 5) as rpm,
    122.5 + (random() * 1 - 0.5) as pressure
FROM generate_series(
    '2025-10-05 00:00'::timestamp,
    '2025-10-30 21:00'::timestamp,
    '3 hours'::interval
) gs;

INSERT INTO pump_sensors (pump_id, timestamp, temperature, vibration, current, rpm, pressure)
SELECT
    3 as pump_id,
    gs as timestamp,
    70.0 + (random() * 4 - 2) as temperature,
    2.0 + (random() * 0.6 - 0.3) as vibration,
    54.5 + (random() * 1 - 0.5) as current,
    1432 + (random() * 10 - 5) as rpm,
    115.5 + (random() * 1 - 0.5) as pressure
FROM generate_series(
    '2025-10-05 00:00'::timestamp,
    '2025-10-30 21:00'::timestamp,
    '3 hours'::interval
) gs;

INSERT INTO pump_sensors (pump_id, timestamp, temperature, vibration, current, rpm, pressure)
SELECT
    5 as pump_id,
    gs as timestamp,
    71.0 + (random() * 4 - 2) + 
        GREATEST(0, EXTRACT(EPOCH FROM (gs - '2025-10-20 00:00'::timestamp)) / 86400 * 0.5) as temperature,
    2.2 + (random() * 0.4) + 
        GREATEST(0, EXTRACT(EPOCH FROM (gs - '2025-10-20 00:00'::timestamp)) / 86400 * 0.8) as vibration,
    56.0 + (random() * 1 - 0.5) as current,
    1462 + (random() * 10 - 5) as rpm,
    119.5 + (random() * 1 - 0.5) as pressure
FROM generate_series(
    '2025-10-05 00:00'::timestamp,
    '2025-10-30 21:00'::timestamp,
    '3 hours'::interval
) gs;