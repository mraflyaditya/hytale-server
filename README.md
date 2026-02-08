<div align="center">

# 🎮 Hytale Docker Server

**Secure and optimized Docker image to self-host your Hytale game server.**

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Docker Image](https://img.shields.io/docker/v/cyvdev/hytale-server?sort=semver&label=Docker%20Hub)](https://hub.docker.com/r/cyvdev/hytale-server)
<!-- [![Docker Image Size](https://img.shields.io/docker/image-size/tonuser/hytale-server/latest)](https://hub.docker.com/r/tonuser/hytale-server)
[![Docker Pulls](https://img.shields.io/docker/pulls/tonuser/hytale-server)](https://hub.docker.com/r/tonuser/hytale-server)
[![CI](https://github.com/tonuser/hytale-docker/actions/workflows/ci.yml/badge.svg)](https://github.com/tonuser/hytale-docker/actions/workflows/ci.yml)
[![Security Scan](https://github.com/tonuser/hytale-docker/actions/workflows/security-scan.yml/badge.svg)](https://github.com/tonuser/hytale-docker/actions/workflows/security-scan.yml)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/tonuser/hytale-docker/badge)](https://securityscorecards.dev/viewer/?uri=github.com/tonuser/hytale-docker) -->

**Java 25** • **Alpine Linux** • **Multi-Stage Build** • **ZGC** • **Rootless**

**🌍 Language / Langue / Idioma / Sprache**

[![English](https://img.shields.io/badge/English-blue?style=for-the-badge)](README.md)
[![Français](https://img.shields.io/badge/Français-blue?style=for-the-badge)](docs/fr/README.md)

<!-- [Quick Start](#-quick-start) •
[Configuration](#-configuration) •
[Sécurité](#-sécurité) •
[Performance](#-performance) •
[Contributing](#-contributing) -->

---

</div>

<!-- ## ✨ Fonctionnalités

| Catégorie | Détails |
|-----------|---------|
| 🔒 **Sécurité** | Rootless, read-only FS, no-new-privileges, capabilities droppées, Log4Shell protégé |
| ⚡ **Performance** | JRE custom via jlink, ZGC/G1GC/Shenandoah, flags JVM optimisés gaming |
| 📦 **Image légère** | ~180MB grâce au multi-stage build + Alpine + JRE minimal |
| 🔄 **Résilience** | Healthcheck multi-critères, arrêt gracieux, auto-restart |
| 💾 **Backups** | Backup automatique compressé zstd avec rotation |
| 📊 **Monitoring** | JFR optionnel, JMX sécurisé, métriques Docker natives |
| 🐧 **Java 25** | Eclipse Temurin JDK 25 avec les dernières optimisations |

## 📋 Prérequis

- Docker Engine ≥ 24.0
- Docker Compose ≥ 2.20
- 4 GB RAM minimum (8 GB recommandé)
- 10 GB espace disque minimum

## 🚀 Quick Start

### Option 1 : Docker Compose (Recommandé)

```bash
# Cloner le repository
git clone https://github.com/tonuser/hytale-docker.git
cd hytale-docker

# Configurer
cp examples/.env.example .env
# Éditer .env avec vos paramètres

# Lancer
docker compose -f docker/docker-compose.yml up -d

# Voir les logs
docker compose -f docker/docker-compose.yml logs -f
 -->

## Quick Start

```bash
docker run -d \
  --name hytale \
  -p 25565:25565 \
  -v hytale-data:/opt/hytale/data \
  tonuser/hytale-server:latest
```

### Docker Compose

```bash
git clone https://github.com/tonuser/hytale-docker.git
cd hytale-docker
docker compose up -d
```

### Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `HYTALE_MEMORY` | `2G` | Memory allocated to the server |
| `HYTALE_PORT` | `25565` | Server port |
| `JAVA_OPTS` | _(empty)_ | Additional JVM flags |

### Build locally

```bash
docker build -t hytale-server .
```

## License

[![Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)