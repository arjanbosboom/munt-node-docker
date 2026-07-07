# Development Guide

This document explains how the image is built and how to work on this repository.

## Build model

The `Dockerfile` uses a multi-stage build:

1. Build stage (Ubuntu 22.04):
- Clones `munt-official`
- Builds dependencies
- Compiles `Munt-daemon` and `Munt-cli`

2. Runtime stage (Ubuntu 22.04):
- Installs minimal runtime dependencies
- Copies binaries from builder
- Runs as non-root user `munt`

## Local development workflow

Build and start:

```bash
docker compose up -d --build
```

Inspect logs:

```bash
docker compose logs -f munt-node
```

Execute CLI in container:

```bash
docker compose exec -T munt-node Munt-cli -datadir=/home/munt/.munt getblockcount
```

## Updating upstream source

The build pulls source during image build from:

- `https://github.com/arjanbosboom/munt-official.git`

To refresh to latest upstream state:

```bash
./scripts/update.sh
```

## Repository conventions

- Keep runtime settings in `config/munt.conf`
- Keep persistent data in `./data`
- Keep README concise and move deep-dive docs to `docs/`

## Suggested future improvements

- Pin upstream commit hash for stricter reproducibility
- Add CI build job for image validation
- Add container image signing and SBOM generation