FROM apache/superset:latest

USER root

RUN /app/.venv/bin/python -m ensurepip --upgrade || true
RUN /app/.venv/bin/python -m pip install --no-cache-dir --upgrade pip
RUN /app/.venv/bin/python -m pip install --no-cache-dir psycopg2-binary

USER superset