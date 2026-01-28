# Agent Guide: architect-project-planer-devops

## Mission
Maintain the local development stack for the Architect Project Planner system. Focus on Docker Compose, service configuration, and deployment/maintenance scripts.

## Quick map
- `local-dev/docker-compose.yml`: single source of truth for the local stack
- `local-dev/*`: per-service config (Grafana, Keycloak, Loki, Nginx, PgAdmin, Postgres, Prometheus, SonarQube)
- `local-dev/scripts/`: operational scripts (deploy/update/cleanup)
- `local-dev/README.md`: service access table (keep aligned with compose)

## Stack summary (compose-driven)
- Postgres (pgvector) + pgAdmin
- SonarQube + dedicated Postgres DB
- Prometheus + Loki + Grafana
- Keycloak
- Nginx static page
- MailHog

## Service endpoints (local defaults)
- Postgres: `localhost:5432` (DB `archplan`, user `postgres`, pass `P@ssw0rd`)
- pgAdmin: `http://localhost:5050` (admin@local.com / admin)
- SonarQube: `http://localhost:9000`
- Prometheus: `http://localhost:9090`
- Loki: `http://localhost:3100`
- Grafana: `http://localhost:3001` (admin / admin)
- Keycloak: `http://localhost:5080` (admin / admin)
- Nginx: `http://localhost:80`
- MailHog: UI `http://localhost:8025`, SMTP `localhost:1025`

## Scripts (Ubuntu server operations)
- `local-dev/scripts/deploy-to-vm.sh`: install Docker + Compose, apply Sonar sysctl, optionally install systemd unit
- `local-dev/scripts/update-stack.sh`: git pull and restart the stack (optional full reset)
- `local-dev/scripts/cleanup.sh`: stop stack; optional volume/network removal; VM/systemd cleanup

## Rules of engagement
- Treat `local-dev/docker-compose.yml` as the canonical source of ports, credentials, and networks.
- If you change ports/credentials in compose, update `README.md` and `local-dev/README.md` to match.
- Avoid destructive actions (volume/network removal) unless explicitly requested.
- Prefer editing scripts with safety in mind (idempotent, clear prompts, `set -euo pipefail`).

## Useful commands
- Start stack: `docker compose -f local-dev/docker-compose.yml up -d`
- Stop stack: `docker compose -f local-dev/docker-compose.yml down`
- View logs: `docker compose -f local-dev/docker-compose.yml logs -f --tail=200`
- Pull images: `docker compose -f local-dev/docker-compose.yml pull`

## Notes
- Dedicated network: `archplan-network` with subnet `172.50.0.0/24`.
- Keep this guide brief and aligned with actual configs.
