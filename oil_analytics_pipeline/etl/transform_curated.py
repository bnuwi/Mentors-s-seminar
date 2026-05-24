import pandas as pd
import s3fs

from config import (
    get_s3_endpoint_url,
    MINIO_ACCESS_KEY,
    MINIO_SECRET_KEY,
    S3_BUCKET_RAW,
    S3_BUCKET_CURATED,
)


def get_s3_filesystem():
    return s3fs.S3FileSystem(
        key=MINIO_ACCESS_KEY,
        secret=MINIO_SECRET_KEY,
        client_kwargs={"endpoint_url": get_s3_endpoint_url()},
    )


def read_parquet_dataset(path: str) -> pd.DataFrame:
    fs = get_s3_filesystem()
    files = fs.glob(path)
    if not files:
        raise FileNotFoundError(f"No files found for path: {path}")
    return pd.concat(
        [pd.read_parquet(f"s3://{file}", filesystem=fs) for file in files],
        ignore_index=True
    )


def write_parquet(df: pd.DataFrame, path: str):
    fs = get_s3_filesystem()
    with fs.open(path, "wb") as f:
        df.to_parquet(f, index=False)


def clean_production(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()

    df["date"] = pd.to_datetime(df["date"])
    numeric_cols = [
        "oil_ton", "gas_m3", "water_m3", "energy_kwh",
        "downtime_hours", "temperature", "pressure"
    ]

    for col in numeric_cols:
        df[col] = pd.to_numeric(df[col], errors="coerce")

    df["oil_ton"] = df["oil_ton"].fillna(0)
    df["downtime_hours"] = df["downtime_hours"].fillna(0)

    df["temperature"] = df.groupby("well_id")["temperature"].transform(
        lambda s: s.fillna(s.median())
    )
    df["pressure"] = df.groupby("well_id")["pressure"].transform(
        lambda s: s.fillna(s.median())
    )

    df = df[(df["oil_ton"] >= 0) & (df["oil_ton"] <= 1000)]
    df = df[(df["downtime_hours"] >= 0) & (df["downtime_hours"] <= 24)]

    return df


def clean_well_telemetry(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()

    df["timestamp"] = pd.to_datetime(df["timestamp"])
    df["date"] = df["timestamp"].dt.date

    numeric_cols = [
        "pump_speed_rpm", "pump_current", "pressure_in",
        "pressure_out", "temperature", "vibration", "oil_flow_rate"
    ]

    for col in numeric_cols:
        df[col] = pd.to_numeric(df[col], errors="coerce")

    for col in numeric_cols:
        df[col] = df.groupby("well_id")[col].transform(lambda s: s.fillna(s.median()))

    df = df[(df["temperature"] >= -50) & (df["temperature"] <= 200)]
    df = df[(df["pressure_out"] >= 0) & (df["pressure_out"] <= 1000)]
    df = df[(df["oil_flow_rate"] >= 0)]

    return df


def build_mart_production_daily(production_df: pd.DataFrame) -> pd.DataFrame:
    mart = (
        production_df.groupby("date", as_index=False)
        .agg(
            total_oil_ton=("oil_ton", "sum"),
            total_gas_m3=("gas_m3", "sum"),
            total_water_m3=("water_m3", "sum"),
            total_energy_kwh=("energy_kwh", "sum"),
            total_downtime_hours=("downtime_hours", "sum"),
            avg_temperature=("temperature", "mean"),
            avg_pressure=("pressure", "mean"),
            active_wells=("well_id", "nunique"),
        )
        .sort_values("date")
    )

    mart["downtime_pct"] = (mart["total_downtime_hours"] / (mart["active_wells"] * 24)) * 100
    return mart


def build_mart_well_kpi(production_df: pd.DataFrame, telemetry_df: pd.DataFrame) -> pd.DataFrame:
    prod_kpi = (
        production_df.groupby("well_id", as_index=False)
        .agg(
            total_oil_ton=("oil_ton", "sum"),
            avg_oil_ton=("oil_ton", "mean"),
            total_downtime_hours=("downtime_hours", "sum"),
            avg_prod_temperature=("temperature", "mean"),
            avg_prod_pressure=("pressure", "mean"),
            days_count=("date", "nunique"),
        )
    )

    prod_kpi["downtime_pct"] = (prod_kpi["total_downtime_hours"] / (prod_kpi["days_count"] * 24)) * 100

    tel_kpi = (
        telemetry_df.groupby("well_id", as_index=False)
        .agg(
            avg_telemetry_temperature=("temperature", "mean"),
            avg_telemetry_pressure=("pressure_out", "mean"),
            avg_oil_flow_rate=("oil_flow_rate", "mean"),
            avg_vibration=("vibration", "mean"),
        )
    )

    mart = prod_kpi.merge(tel_kpi, on="well_id", how="left")
    mart["well_rank_by_avg_oil"] = mart["avg_oil_ton"].rank(ascending=False, method="dense")

    return mart.sort_values("avg_oil_ton", ascending=False)


def main():
    production = read_parquet_dataset(f"{S3_BUCKET_RAW}/production/*/*.parquet")
    telemetry = read_parquet_dataset(f"{S3_BUCKET_RAW}/well_telemetry/*/*.parquet")

    production = clean_production(production)
    telemetry = clean_well_telemetry(telemetry)

    write_parquet(production, f"s3://{S3_BUCKET_CURATED}/clean/production/production_clean.parquet")
    write_parquet(telemetry, f"s3://{S3_BUCKET_CURATED}/clean/well_telemetry/well_telemetry_clean.parquet")

    mart_daily = build_mart_production_daily(production)
    mart_well = build_mart_well_kpi(production, telemetry)

    write_parquet(mart_daily, f"s3://{S3_BUCKET_CURATED}/marts/mart_production_daily.parquet")
    write_parquet(mart_well, f"s3://{S3_BUCKET_CURATED}/marts/mart_well_kpi.parquet")

    print("Curated layer and marts were successfully created.")


if __name__ == "__main__":
    main()