#!/bin/bash
set -e

echo "OpenClaw starting..."

# Fix permissions on volume if we can
if [ -d /data ]; then
    echo "Setting up /data directories..."
    mkdir -p /data/workspace 2>/dev/null || true
    mkdir -p /data/.openclaw 2>/dev/null || true
fi

# Start OpenClaw gateway
echo "Starting gateway..."
exec node /app/dist/index.js gateway --port 18789 --bind 0.0.0.0
