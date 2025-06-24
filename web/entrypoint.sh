#!/bin/sh
set -e

echo "Starting Dify Web server..."

# Use PM2 to manage the Next.js application
exec pm2-runtime start server.js --name "dify-web" --instances ${PM2_INSTANCES:-1}