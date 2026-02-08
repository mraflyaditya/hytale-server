#!/bin/sh
set -e

echo "════════════════════════════════════════"
echo "  🎮 Hytale Docker Server"
echo "════════════════════════════════════════"
echo "  Memory : ${HYTALE_MEMORY}"
echo "  Port   : ${HYTALE_PORT}"
echo "  Java   : $(java --version 2>&1 | head -1)"
echo "════════════════════════════════════════"

cd /opt/hytale/data

# Vérifier si le JAR du serveur existe
SERVER_JAR=$(find . -maxdepth 1 -name "*.jar" -type f | head -1)

if [ -z "$SERVER_JAR" ]; then
    echo ""
    echo "⚠️  No server JAR found in /opt/hytale/data"
    echo ""
    echo "Place your Hytale server .jar file in the data volume:"
    echo "  docker cp server.jar hytale:/opt/hytale/data/"
    echo ""
    echo "Or mount it directly:"
    echo "  docker run -v /path/to/server.jar:/opt/hytale/data/server.jar ..."
    echo ""
    echo "Waiting for server JAR..."
    
    # Attendre qu'un JAR apparaisse (permet de copier après le démarrage)
    while [ -z "$SERVER_JAR" ]; do
        sleep 5
        SERVER_JAR=$(find . -maxdepth 1 -name "*.jar" -type f | head -1)
    done
    
    echo "✅ Found: $SERVER_JAR"
fi

echo "🚀 Starting server: $SERVER_JAR"

exec java \
    -Xms${HYTALE_MEMORY} \
    -Xmx${HYTALE_MEMORY} \
    -XX:+UseZGC \
    -XX:+ZGenerational \
    ${JAVA_OPTS} \
    -jar "$SERVER_JAR" \
    --port "${HYTALE_PORT}"
