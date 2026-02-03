#!/bin/sh
set -e

# Create required directories at runtime (after volume mount)
echo "Setting up /data directories..."
mkdir -p /data/workspace /data/.openclaw /data/cron /data/logs /data/agents 2>/dev/null || true

# Start OpenClaw gateway
echo "Starting OpenClaw gateway..."
exec node dist/index.js gateway --allow-unconfigured --bind lan
