#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT_DIR"

if ! command -v docker >/dev/null 2>&1; then
  echo "Error: docker is not installed or not in PATH."
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  echo "Error: docker compose v2 is required."
  exit 1
fi

mkdir -p data

docker compose build --pull munt-node
docker compose up -d munt-node

echo "Update complete. Check status with: docker compose ps"
echo "Follow logs with: docker compose logs -f munt-node"