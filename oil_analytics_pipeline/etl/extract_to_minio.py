import os
from datetime import datetime

import pandas as pd
import s3fs
from sqlalchemy import create_engine

from config import (
    get_postgres_url,
    get_s3_endpoint_url,
    MINIO_ACCESS_KEY,
    MINIO_SECRET_KEY,
    S3_BUCKET_RAW,
)


def get_engine():
    return create_engine(get_postgres_url())


def get_s3_filesystem():
    return s3fs.S3FileSystem(
        key=MINIO_ACCESS_KEY,
        secret=MINIO_SECRET_KEY,
        client_kwargs={"endpoint_url": get_s3_endpoint_url()},
    )


def read_sql(query: str) -> pd.DataFrame:
    engine = get_engine()
    with engine.connect() as conn:
        return pd.read_sql(query, conn)


def write_partitioned_parquet(df: pd.DataFrame, dataset_name: str, partition_col: str):
    if df.empty:
        print(f"[SKIP] {dataset_name}: dataframe is empty")
        return

    fs = get_s3_filesystem()
    df = df.copy()
    df[partition_col] = pd.to_datetime(df[partition_col]).dt.date

    for partition_value, part_df in df.groupby(partition_col):
        partition_value = str(partition_value)
        s3_path = f"s3://{S3_BUCKET_RAW}/{dataset_name}/{partition_col}={partition_value}/data.parquet"

        with fs.open(s3_path, "wb") as f:
            part_df.to_parquet(f, index=False)

        print(f"[OK] {dataset_name}: {len(part_df)} rows -> {s3_path}")


def export_wells():
    df = read_sql("SELECT * FROM wells")
    fs = get_s3_filesystem()
    s3_path = f"s3://{S3_BUCKET_RAW}/wells/data.parquet"
    with fs.open(s3_path, "wb") as f:
        df.to_parquet(f, index=False)
    print(f"[OK] wells: {len(df)} rows -> {s3_path}")


def export_production():
    df = read_sql("SELECT * FROM production")
    write_partitioned_parquet(df, "production", "date")


def export_well_telemetry():
    df = read_sql("SELECT * FROM well_telemetry")
    df["date"] = pd.to_datetime(df["timestamp"]).dt.date
    write_partitioned_parquet(df, "well_telemetry", "date")


def export_well_targets():
    df = read_sql("SELECT * FROM well_targets")
    write_partitioned_parquet(df, "well_targets", "date")


def export_pumps():
    df = read_sql("SELECT * FROM pumps")
    fs = get_s3_filesystem()
    s3_path = f"s3://{S3_BUCKET_RAW}/pumps/data.parquet"
    with fs.open(s3_path, "wb") as f:
        df.to_parquet(f, index=False)
    print(f"[OK] pumps: {len(df)} rows -> {s3_path}")


def export_pump_sensors():
    df = read_sql("SELECT * FROM pump_sensors")
    df["date"] = pd.to_datetime(df["timestamp"]).dt.date
    write_partitioned_parquet(df, "pump_sensors", "date")


def export_pump_failures():
    df = read_sql("SELECT * FROM pump_failures")
    df["date"] = pd.to_datetime(df["failure_date"]).dt.date
    write_partitioned_parquet(df, "pump_failures", "date")


def export_drivers():
    df = read_sql("SELECT * FROM drivers")
    fs = get_s3_filesystem()
    s3_path = f"s3://{S3_BUCKET_RAW}/drivers/data.parquet"
    with fs.open(s3_path, "wb") as f:
        df.to_parquet(f, index=False)
    print(f"[OK] drivers: {len(df)} rows -> {s3_path}")


def export_vehicles():
    df = read_sql("SELECT * FROM vehicles")
    fs = get_s3_filesystem()
    s3_path = f"s3://{S3_BUCKET_RAW}/vehicles/data.parquet"
    with fs.open(s3_path, "wb") as f:
        df.to_parquet(f, index=False)
    print(f"[OK] vehicles: {len(df)} rows -> {s3_path}")


def export_deliveries():
    df = read_sql("SELECT * FROM deliveries")
    write_partitioned_parquet(df, "deliveries", "date")


def main():
    start = datetime.now()
    print(f"ETL started at {start}")

    export_wells()
    export_production()
    export_well_telemetry()
    export_well_targets()
    export_pumps()
    export_pump_sensors()
    export_pump_failures()
    export_drivers()
    export_vehicles()
    export_deliveries()

    end = datetime.now()
    print(f"ETL finished at {end}, duration: {end - start}")


if __name__ == "__main__":
    main()