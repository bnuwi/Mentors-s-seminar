import os
from dotenv import load_dotenv

load_dotenv()

POSTGRES_HOST = os.getenv("POSTGRES_HOST", "postgres")
POSTGRES_PORT = os.getenv("POSTGRES_PORT", "5432")
POSTGRES_DB = os.getenv("POSTGRES_DB", "oil_pipeline")
POSTGRES_USER = os.getenv("POSTGRES_USER", "oil_user")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD", "oil_password")

MINIO_ENDPOINT = os.getenv("MINIO_ENDPOINT", "minio:9000")
MINIO_ACCESS_KEY = os.getenv("AWS_ACCESS_KEY_ID", "minioadmin")
MINIO_SECRET_KEY = os.getenv("AWS_SECRET_ACCESS_KEY", "minioadmin123")
MINIO_SECURE = os.getenv("MINIO_SECURE", "false").lower() == "true"

S3_BUCKET_RAW = os.getenv("S3_BUCKET_RAW", "raw")
S3_BUCKET_STAGING = os.getenv("S3_BUCKET_STAGING", "staging")
S3_BUCKET_CURATED = os.getenv("S3_BUCKET_CURATED", "curated")


def get_postgres_url() -> str:
    return (
        f"postgresql+psycopg2://{POSTGRES_USER}:{POSTGRES_PASSWORD}"
        f"@{POSTGRES_HOST}:{POSTGRES_PORT}/{POSTGRES_DB}"
    )


def get_s3_endpoint_url() -> str:
    protocol = "https" if MINIO_SECURE else "http"
    return f"{protocol}://{MINIO_ENDPOINT}"