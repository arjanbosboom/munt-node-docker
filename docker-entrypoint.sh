#!/usr/bin/env bash
set -e

DATADIR="/home/munt/.munt"

mkdir -p "$DATADIR"
mkdir -p "$DATADIR/blocks"
mkdir -p "$DATADIR/chainstate"

chown -R munt:munt "$DATADIR"

exec gosu munt "$@"