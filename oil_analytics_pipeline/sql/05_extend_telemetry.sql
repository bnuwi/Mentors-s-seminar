INSERT INTO well_telemetry (well_id, timestamp, pump_speed_rpm, pump_current, pressure_in, pressure_out, temperature, vibration, oil_flow_rate)
SELECT
    1 as well_id,
    gs as timestamp,
    1470 + (random() * 10 - 5) as pump_speed_rpm,
    58.2 + (random() * 1 - 0.5) as pump_current,
    95.0 + (random() * 1 - 0.5) as pressure_in,
    122.0 + (random() * 1 - 0.5) as pressure_out,
    88.0 + (random() * 2 - 1) as temperature,
    1.5 + (random() * 0.5) as vibration,
    8.8 + (random() * 0.4 - 0.2) as oil_flow_rate
FROM generate_series(
    '2025-10-02 00:00'::timestamp,
    '2025-10-30 23:00'::timestamp,
    '1 hour'::interval
) gs;

INSERT INTO well_telemetry (well_id, timestamp, pump_speed_rpm, pump_current, pressure_in, pressure_out, temperature, vibration, oil_flow_rate)
SELECT
    2 as well_id,
    gs as timestamp,
    1430 + (random() * 10 - 5) as pump_speed_rpm,
    54.5 + (random() * 1 - 0.5) as pump_current,
    91.2 + (random() * 1 - 0.5) as pressure_in,
    115.4 + (random() * 1 - 0.5) as pressure_out,
    84.3 + (random() * 2 - 1) as temperature,
    1.5 + (random() * 0.5) as vibration,
    7.5 + (random() * 0.4 - 0.2) as oil_flow_rate
FROM generate_series(
    '2025-10-02 00:00'::timestamp,
    '2025-10-30 23:00'::timestamp,
    '1 hour'::interval
) gs;

INSERT INTO well_telemetry (well_id, timestamp, pump_speed_rpm, pump_current, pressure_in, pressure_out, temperature, vibration, oil_flow_rate)
SELECT
    5 as well_id,
    gs as timestamp,
    1460 + (random() * 10 - 5) as pump_speed_rpm,
    56.1 + (random() * 1 - 0.5) as pump_current,
    90.0 + (random() * 1 - 0.5) as pressure_in,
    119.4 + (random() * 1 - 0.5) as pressure_out,
    86.5 + (random() * 2 - 1) as temperature,
    2.0 + (random() * 0.5) as vibration,
    8.2 + (random() * 0.4 - 0.2) as oil_flow_rate
FROM generate_series(
    '2025-10-02 00:00'::timestamp,
    '2025-10-30 23:00'::timestamp,
    '1 hour'::interval
) gs;