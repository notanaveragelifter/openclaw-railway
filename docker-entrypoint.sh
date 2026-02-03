#!/bin/sh
set -e

# Setup directories (as root, this will always succeed on Railway volumes)
echo "Ensuring /data directories exist with correct permissions..."
mkdir -p /data/workspace /data/cron /data/logs /data/agents

# Ensure permissions are correct (redundant but safe)
chmod -R 755 /data

# Start OpenClaw gateway on port 8080 (Railway requires this for HTTP proxy)
# Binds to 'lan' to allow external traffic through Railway HTTP proxy
echo "Starting OpenClaw gateway on port 8080..."
exec node dist/index.js gateway --allow-unconfigured --bind lan --port 8080
