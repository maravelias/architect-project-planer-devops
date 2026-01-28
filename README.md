# architect-project-planer-devops

Local development stack for the Architect Project Planner system. It runs a full dev environment with Docker Compose (Postgres, pgAdmin, SonarQube, Prometheus, Loki, Grafana, Keycloak, Nginx, MailHog).

This repository is intended for development and testing only. It is not a production deployment guide.

## Prerequisites
- Docker Engine
- Docker Compose v2 (the `docker compose` plugin)
- Ubuntu 20.04+ or 22.04+ recommended for server installs

## Quick start (local)
```bash
cd local-dev
docker compose up -d
```

Check status:
```bash
docker compose ps
```

Stop everything:
```bash
docker compose down
```

## Service endpoints (local defaults)
| Service | URL / Port | Default credentials |
| :--- | :--- | :--- |
| Postgres | `localhost:5432` | DB `archplan`, user `postgres`, pass `P@ssw0rd` |
| pgAdmin | `http://localhost:5050` | `admin@local.com` / `admin` |
| SonarQube | `http://localhost:9000` | - |
| Prometheus | `http://localhost:9090` | - |
| Loki | `http://localhost:3100` | - |
| Grafana | `http://localhost:3001` | `admin` / `admin` |
| Keycloak | `http://localhost:5080` | `admin` / `admin` |
| Nginx | `http://localhost:80` | - |
| MailHog | UI `http://localhost:8025` | SMTP `localhost:1025` |

Postgres connection string:
```
postgresql://postgres:P@ssw0rd@localhost:5432/archplan
```

For full access details, see `local-dev/README.md`.

## Repository layout
- `local-dev/docker-compose.yml`: main stack definition (ports, credentials, networks)
- `local-dev/*`: per-service config (Grafana, Keycloak, Loki, Nginx, PgAdmin, Postgres, Prometheus, SonarQube)
- `local-dev/scripts/`: Ubuntu server scripts (deploy/update/cleanup)
- `local-dev/README.md`: detailed access table for the stack

## Ubuntu server scripts
These scripts live in `local-dev/scripts` and are designed for VM/Ubuntu usage.

- Deploy stack + install Docker:
```bash
sudo bash local-dev/scripts/deploy-to-vm.sh
```

- Deploy and install systemd unit (auto-start on boot):
```bash
sudo bash local-dev/scripts/deploy-to-vm.sh --with-systemd
```

- Update the stack (pull git + restart):
```bash
bash local-dev/scripts/update-stack.sh
```

- Cleanup stack (interactive):
```bash
bash local-dev/scripts/cleanup.sh --local
```

## Install on a server (Ubuntu)
Clone the repository and run the deploy script. Replace the target path if needed.

```bash
sudo mkdir -p /opt
sudo chown "$USER":"$USER" /opt
git clone https://github.com/maravelias/architect-project-planer-devops /opt/architect-project-planer-devops
cd /opt/architect-project-planer-devops
sudo bash local-dev/scripts/deploy-to-vm.sh --with-systemd
```

Notes:
- The deploy script installs Docker Engine + Compose plugin, applies the SonarQube sysctl, and starts the stack.
- `--with-systemd` creates a service so the stack auto-starts on boot.
- Systemd service name: `archplan-local-stack.service`.

## Update process (server or local)
Use the update script to pull latest changes and restart the stack.

```bash
cd /opt/architect-project-planer-devops
bash local-dev/scripts/update-stack.sh
```

Optional full reset (removes volumes and network):
```bash
bash local-dev/scripts/update-stack.sh --full-reset
```

## How to verify
- `docker compose -f local-dev/docker-compose.yml ps` shows services running
- Open Grafana, Keycloak, and SonarQube in a browser to confirm UI access

## Data persistence
- Data is stored in named Docker volumes and survives restarts.
- `--full-reset` wipes volumes and deletes the stack network (destructive).

## Common issues
- SonarQube requires `vm.max_map_count=262144` (the deploy script applies this on Ubuntu).
- If ports are in use (80, 3001, 5050, 5080, 8025, 9000), stop conflicting services or change ports in compose.
- If you were just added to the `docker` group, re-login is required for non-root docker usage.

## Notes
- Docker network: `archplan-network` with subnet `172.50.0.0/24`.
- If you change ports or credentials in compose, update `README.md` and `local-dev/README.md` to stay in sync.
