# Installation Guide

This guide explains how to install and run the Munt node container on Linux (Ubuntu 22.04+ or Debian recommended).

## Prerequisites

- Docker Engine
- Docker Compose v2 (`docker compose`)

## Ubuntu 22.04+ notes

On some Ubuntu systems (22.04, 24.04, and newer), you may need to install both Docker and Compose tooling explicitly:

```bash
sudo apt update
sudo apt install -y docker.io docker-compose docker-compose-v2
```

Depending on your setup, Docker commands may require root privileges:

```bash
sudo docker compose up -d --build
```

or (legacy command):

```bash
sudo docker-compose up -d --build
```

If you want to run Docker without `sudo`, add your user to the `docker` group and log out/in:

```bash
sudo usermod -aG docker "$USER"
```

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