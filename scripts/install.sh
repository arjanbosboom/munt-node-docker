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

if [ ! -f "config/munt.conf" ]; then
  cp "config/Munt.conf.example" "config/munt.conf"
  echo "Created config/munt.conf from template."
  echo "Please edit rpcpassword before exposing RPC beyond localhost."
fi

mkdir -p data

docker compose up -d --build

echo "Munt node is starting. Follow logs with: docker compose logs -f munt-node"