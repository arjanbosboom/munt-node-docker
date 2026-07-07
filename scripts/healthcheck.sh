#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT_DIR"

if ! command -v docker >/dev/null 2>&1; then
  echo "Error: docker is not installed or not in PATH."
  exit 1
fi

if ! docker compose ps munt-node >/dev/null 2>&1; then
  echo "Error: compose service 'munt-node' not found."
  exit 1
fi

STATUS="$(docker compose ps --format json munt-node | tr -d '\r' | grep -o '"state":"[^"]*"' | head -n1 | cut -d':' -f2 | tr -d '"')"

if [ "$STATUS" != "running" ]; then
  echo "Unhealthy: munt-node container state is '$STATUS'."
  exit 1
fi

if docker compose exec -T munt-node Munt-cli -datadir=/home/munt/.munt getblockcount >/dev/null 2>&1; then
  echo "Healthy: container is running and RPC responds to Munt-cli."
  exit 0
fi

echo "Unhealthy: container is running but Munt-cli RPC check failed."
exit 1