# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/).

## [0.1.0] - 2026-02-08

### Added
- Initial Dockerfile with Java 25 (Eclipse Temurin) + Alpine Linux
- Multi-stage build with custom JRE via jlink
- Entrypoint script with auto-detection of server JAR
- Docker Compose setup
- GitHub Actions pipeline for automated release to Docker Hub & GHCR
