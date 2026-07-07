# Munt Node (Docker)

Run a Munt full node in Docker with a reproducible, Linux-first setup.

## Highlights

- 🚀 One-command deployment (`docker compose up -d`)
- 💾 Persistent blockchain storage
- 🔄 Automatic restart
- 🔒 Secure default configuration
- 🐳 Docker & Docker Compose support
- 🐧 Linux-first (Ubuntu/Debian)
- 📦 Reproducible builds

## What This Project Provides

This repository builds `Munt-daemon` and `Munt-cli` from source using a multi-stage Docker build, then runs the node in a minimal runtime container.

- P2P port exposed on `9231`
- RPC port mapped to localhost only (`127.0.0.1:9232`)
- Persistent chain data via `./data`
- Read-only config mount from `./config/munt.conf`
- Container restart policy: `unless-stopped`

## Quick Start

```bash
cp config/Munt.conf.example config/munt.conf
docker compose up -d --build
```

For full installation steps, see [docs/INSTALL.md](docs/INSTALL.md).

## Project Structure

```text
.
├── Dockerfile
├── docker-compose.yml
├── README.md
├── LICENSE
├── config/
│   ├── Munt.conf.example
│   └── munt.conf (local, not committed)
├── scripts/
│   ├── install.sh
│   ├── healthcheck.sh
│   └── update.sh
└── docs/
	├── INSTALL.md
	├── SECURITY.md
	└── DEVELOPMENT.md
```

## Scripts

- `./scripts/install.sh`: prerequisite checks, config bootstrap, and first startup
- `./scripts/healthcheck.sh`: verifies container state and RPC responsiveness
- `./scripts/update.sh`: rebuilds image and restarts service

## Documentation

- Installation: [docs/INSTALL.md](docs/INSTALL.md)
- Security: [docs/SECURITY.md](docs/SECURITY.md)
- Development: [docs/DEVELOPMENT.md](docs/DEVELOPMENT.md)

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE).
