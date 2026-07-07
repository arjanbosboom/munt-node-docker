#!/usr/bin/env bash
set -e

DATADIR="/home/munt/.munt"

mkdir -p "$DATADIR"

if [ "$(id -u)" = "0" ]; then
    chown -R munt:munt "$DATADIR"
    exec gosu munt "$@"
fi

exec "$@"