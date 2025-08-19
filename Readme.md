# SM-Lickitung (OCI)

Minimal container that serves a static HTML+JS tool at /index.html.

> ⚠️ Use at your own risk. Intended only for non-commercial, educational/research purposes on out-of-production Supermicro gear. You are responsible for compliance with all applicable licenses and laws.

## Quick start (Docker Compose)
```yaml
version: "3.9"

services:
  supermicro-license-generator-oci:
    image: prplanit/sm-lickitung-oci:v0.0.2
    container_name: supermicro-license-generator-oci
    ports:
      - "8015:80"   # host:container
    restart: unless-stopped
```

#### Bring it up:
```bash
docker compose up -d
```

#### Open a browser and access: `http://<host>:8015/index.html`

> You can change 8015 to any host port you like (e.g., 80:80, 8080:80, etc).

Quick start (docker run)
```bash
docker run -d --name supermicro-license-generator-oci \
  -p 8015:80 \
  --restart unless-stopped \
  prplanit/sm-lickitung-oci:v0.0.2
```

### What’s inside
Base: Alpine + NGINX
Static site served by NGINX (no server-side code)
Default doc root baked into the image

#### Security notes
- This is HTTP only. If exposing to the internet, put it behind a TLS reverse proxy (nginx/traefik/Cloudflare Tunnel).
- Prefer running it on an internal VLAN or with firewall rules so only trusted IPs can reach it.
- No persistence/volumes are required.

#### Health & logs
```bash
docker logs -f supermicro-license-generator-oci
docker ps
```

#### Troubleshooting
404 on / but /index.html works:
- This image intentionally serves the app at /index.html. Use that path.
- (If you want / to resolve to the app, front it with a tiny NGINX/Traefik proxy that rewrites / → /index.html.)

#### Port conflicts
- Change the left side of ports: in compose (e.g., "8020:80"), then reconnect at http://<host>:8020/index.html.

#### Nothing loads
- Confirm the container is running and reachable from your client network (NAT/Firewall).