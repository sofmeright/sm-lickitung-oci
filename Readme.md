# SM-Lickitung (OCI)

Minimal container that serves a static HTML+JS tool at `/`.

> ⚠️ Use at your own risk. Intended only for non-commercial, educational/research purposes on out-of-production Supermicro gear. You are responsible for compliance with all applicable licenses and laws.

## Quick start (Docker Compose)
```yaml
services:
  supermicro-license-generator-oci:
    image: prplanit/sm-lickitung-oci:v0.0.4
    container_name: supermicro-license-generator-oci
    ports:
      - "8015:8080"   # host:container
    restart: unless-stopped
```

#### Bring it up:
```bash
docker compose up -d
```

#### Open a browser and access: `http://<host>:8015`

> You can change 8015 to any host port you like (e.g., 9090:8080, 8080:8080, etc).

## Quick start (docker run)
```bash
docker run -d --name supermicro-license-generator-oci \
  -p 8015:8080 \
  --restart unless-stopped \
  prplanit/sm-lickitung-oci:v0.0.4
```

### Upgrading from v0.0.2 / v0.0.3

The container port changed from `80` to `8080` and now runs as non-root. Update your port mappings from `8015:80` to `8015:8080`.

### Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `LISTEN_PORT` | `8080` | Port nginx listens on inside the container |

The container runs as non-root (`nginx` user, UID 100) by default.

### What's inside
Base: Alpine + NGINX
Static site served by NGINX (no server-side code)
Default doc root baked into the image

#### Security notes
- Runs as non-root user (UID 100) — no privileged port binding required.
- This is HTTP only. If exposing to the internet, put it behind a TLS reverse proxy (nginx/traefik/Cloudflare Tunnel).
- Prefer running it on an internal VLAN or with firewall rules so only trusted IPs can reach it.
- No persistence/volumes are required.

#### Health & logs
```bash
docker logs -f supermicro-license-generator-oci
docker ps
```

### Troubleshooting

#### Port conflicts
- Change the left side of ports: in compose (e.g., "8020:8080"), then reconnect at http://<host>:8020.

#### Nothing loads
- Confirm the container is running and reachable from your client network (NAT/Firewall).
