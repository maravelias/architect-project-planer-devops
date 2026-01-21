# Local Development Environment

This guide provides information on how to access the services running in the local development stack.

## Getting Started

To start the local development stack, run the following command from this directory:

```bash
docker compose up -d
```

## Services Overview

The local stack includes the following services:

| Service | Internal IP | External Port | Credentials (if applicable) |
| :--- | :--- | :--- | :--- |
| **PostgreSQL** | `172.40.0.10` | `5432` | User: `postgres`, Pass: `P@ssw0rd`, DB: `carrental` |
| **pgAdmin** | `172.40.0.19` | `5050` | Email: `admin@local.com`, Pass: `admin` |
| **SonarQube** | `172.40.0.13` | `9000` | - |
| **Prometheus** | `172.40.0.14` | `9090` | - |
| **Loki** | `172.40.0.15` | `3100` | - |
| **Grafana** | `172.40.0.17` | `3000` | User: `admin`, Pass: `admin` |
| **Nginx** | `172.40.0.16` | `80` | - |
| **MailHog (Web UI)** | `172.40.0.18` | `8025` | - |
| **MailHog (SMTP)** | `172.40.0.18` | `1025` | - |

## Detailed Access Information

### 🐘 Database (PostgreSQL)
- **Host:** `localhost`
- **Port:** `5432`
- **Database:** `archprojectplanner`
- **Username:** `postgres`
- **Password:** `P@ssw0rd`
- **Connection String:** `postgresql://postgres:P@ssw0rd@localhost:5432/archprojectplanner`

### 🛠️ pgAdmin
- **URL:** [http://localhost:5050](http://localhost:5050)
- **Username:** `admin@local.com`
- **Password:** `admin`

### 🔍 SonarQube
- **URL:** [http://localhost:9000](http://localhost:9000)

### 📈 Monitoring (Prometheus & Grafana)
- **Prometheus:** [http://localhost:9090](http://localhost:9090)
- **Grafana:** [http://localhost:3000](http://localhost:3000)
  - **Username:** `admin`
  - **Password:** `admin`

### 🪵 Logging (Loki)
- **URL:** [http://localhost:3100](http://localhost:3100)

### 🌐 Web Server (Nginx)
- **URL:** [http://localhost:80](http://localhost:80)

### ✉️ Email Testing (MailHog)
- **Web UI:** [http://localhost:8025](http://localhost:8025)
- **SMTP Server:** `localhost:1025`

#### Spring Boot Configuration
To use the local MailHog service, update your `application-dev.properties`:

```properties
spring.mail.host=localhost
spring.mail.port=1025
spring.mail.protocol=smtp
spring.mail.username=
spring.mail.password=
spring.mail.properties.mail.smtp.auth=false
spring.mail.properties.mail.smtp.starttls.enable=false
spring.mail.properties.mail.smtp.ssl.enable=false
```

## Network Configuration
The services run on a dedicated bridge network `archprojectplanner-network` with the subnet `172.50.0.0/24`.
