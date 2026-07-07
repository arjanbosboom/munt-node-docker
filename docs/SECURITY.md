# Security Guide

This project is designed with conservative defaults, but secure operation remains your responsibility.

## RPC hardening

- Set a long random `rpcpassword` in `config/munt.conf`
- Keep RPC bound to localhost unless remote access is explicitly required
- Keep `rpcallowip` as narrow as possible

Current compose mapping exposes RPC only to localhost:

- `127.0.0.1:9232:9232`

## Network exposure

- P2P port `9231` is exposed publicly for peer connectivity
- RPC port `9232` should not be exposed publicly

If you change bindings, use firewall rules and network segmentation.

## File permissions

- Keep `config/munt.conf` readable only by trusted users
- Treat RPC credentials as secrets

Recommended:

```bash
chmod 600 config/munt.conf
```

## Container runtime

- The container runs as a non-root user (`munt`)
- Restart policy is `unless-stopped`

## Updates

Rebuild frequently to pick up base image and dependency updates:

```bash
./scripts/update.sh
```

## Incident response basics

If credentials leak:

1. Stop the node
2. Rotate `rpcpassword`
3. Review host/network exposure
4. Restart and monitor logs