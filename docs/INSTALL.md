# Installation Guide

This guide explains how to install and run the Munt node container on Linux (Ubuntu/Debian recommended).

## Prerequisites

- Docker Engine
- Docker Compose v2 (`docker compose`)

## 1. Clone the repository

```bash
git clone https://github.com/arjanbosboom/munt-node-docker.git
cd munt-node-docker
```

## 2. Create local configuration

```bash
cp config/Munt.conf.example config/munt.conf
```

Update at least:

- `rpcpassword` to a long random value
- Optional peer settings (`addnode`)

## 3. Start the node

```bash
docker compose up -d --build
```

## 4. Verify runtime status

```bash
docker compose ps
docker compose logs -f munt-node
```

Optional health check script:

```bash
./scripts/healthcheck.sh
```

## 5. Stop or restart

```bash
docker compose down
docker compose restart munt-node
```

## Data persistence

- Host data path: `./data`
- Container data path: `/home/munt/.munt`

Data in `./data` survives container recreates and host reboots.

## One-command install helper

You can use:

```bash
./scripts/install.sh
```

It checks prerequisites, creates `config/munt.conf` if missing, and starts the service.