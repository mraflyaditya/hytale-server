# ══════════════════════════════════════════════════
#  Hytale Docker Server
#  Java 25 • Alpine Linux • Multi-stage
# ══════════════════════════════════════════════════

# ── Stage 1 : Build custom JRE with jlink ──
FROM eclipse-temurin:25-jdk-alpine AS builder

# Créer un JRE minimal avec uniquement les modules nécessaires
RUN jlink \
    --add-modules java.base,java.logging,java.naming,java.net.http,java.security.jgss,java.sql,jdk.crypto.ec \
    --strip-debug \
    --no-man-pages \
    --no-header-files \
    --compress=zip-6 \
    --output /opt/java-custom

# ── Stage 2 : Image finale minimale ──
FROM alpine:3.21

LABEL org.opencontainers.image.title="Hytale Docker Server" \
      org.opencontainers.image.description="Secure and optimized Docker image for Hytale game servers" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.source="https://github.com/tonuser/hytale-docker"

# Copier le JRE custom
COPY --from=builder /opt/java-custom /opt/java
ENV JAVA_HOME=/opt/java
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Dépendances runtime minimales
RUN apk add --no-cache tini

# Utilisateur non-root
RUN addgroup -S hytale && adduser -S hytale -G hytale

# Structure des dossiers
RUN mkdir -p /opt/hytale/data /opt/hytale/scripts \
    && chown -R hytale:hytale /opt/hytale

WORKDIR /opt/hytale

# Scripts
COPY --chown=hytale:hytale scripts/entrypoint.sh /opt/hytale/scripts/
RUN chmod +x /opt/hytale/scripts/entrypoint.sh

# Utilisateur non-root
USER hytale

# Port serveur
EXPOSE 25565

# Volume pour les données persistantes
VOLUME ["/opt/hytale/data"]

# Variables par défaut
ENV HYTALE_MEMORY="2G" \
    HYTALE_PORT="25565" \
    JAVA_OPTS=""

# Entrypoint avec tini (gestion propre des signaux)
ENTRYPOINT ["tini", "--"]
CMD ["/opt/hytale/scripts/entrypoint.sh"]