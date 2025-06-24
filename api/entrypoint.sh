#!/bin/bash
set -e

# Run database migrations if needed
if [ "$1" = "api" ]; then
    echo "Starting Dify API server..."
    exec python app.py
elif [ "$1" = "worker" ]; then
    echo "Starting Dify worker..."
    exec celery -A app.celery worker --loglevel INFO
elif [ "$1" = "beat" ]; then
    echo "Starting Dify beat scheduler..."
    exec celery -A app.celery beat --loglevel INFO
else
    echo "Starting Dify API server (default)..."
    exec python app.py
fi