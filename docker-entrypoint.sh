#!/bin/sh
set -e

# Setup directories (as root, this will always succeed on Railway volumes)
echo "Ensuring /data directories exist with correct permissions..."
mkdir -p /data/workspace /data/cron /data/logs /data/agents

# Ensure permissions are correct
chmod -R 755 /data

# Copy config file to state directory if it exists in app
if [ -f /app/openclaw.json ]; then
  echo "Copying openclaw.json config to /data..."
  cp /app/openclaw.json /data/openclaw.json
fi

# Set config path environment variable
export OPENCLAW_CONFIG_PATH=/data/openclaw.json

# Start OpenClaw gateway on port 8080 (Railway requires this for HTTP proxy)
# Binds to 'lan' to allow external traffic through Railway HTTP proxy
echo "Starting OpenClaw gateway on port 8080..."
exec node dist/index.js gateway --allow-unconfigured --bind lan --port 8080
