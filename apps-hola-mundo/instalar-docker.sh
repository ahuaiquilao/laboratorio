#!/bin/bash

# ============================================
# SCRIPT: Instalar Aplicación en Docker (Manual)
# Automatiza: PASO 2 y PASO 3
# ============================================

set -e  # Detener en caso de error

echo "╔════════════════════════════════════════════════════════╗"
echo "║   INSTALACIÓN AUTOMÁTICA - Docker Manual               ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

# PASO 1: Navegar al directorio
PROYECTO_DIR="/Users/yastamiro/Personal/Adrian/Laboratorio/apps-hola-mundo"

if [ ! -d "$PROYECTO_DIR" ]; then
    echo "❌ Error: Directorio no encontrado: $PROYECTO_DIR"
    exit 1
fi

cd "$PROYECTO_DIR"
echo "✅ PASO 1: Directorio correcto: $PWD"
echo ""

# Verificar que Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "❌ Error: Docker no está instalado"
    exit 1
fi

echo "✅ Docker está disponible"
echo ""

# PASO 2: Construir imagen
echo "⏳ PASO 2: Construyendo imagen Docker..."
echo ""

if docker build -t hola-mundo-app:latest .; then
    echo ""
    echo "✅ Imagen construida exitosamente"
else
    echo ""
    echo "❌ Error al construir la imagen"
    exit 1
fi

echo ""

# Verificar si el contenedor anterior existe y eliminarlo
if docker ps -a --filter "name=hola-mundo-app" --quiet | grep -q .; then
    echo "⚠️  Contenedor anterior encontrado, eliminando..."
    docker stop hola-mundo-app 2>/dev/null || true
    docker rm hola-mundo-app 2>/dev/null || true
    echo "✅ Contenedor anterior eliminado"
    echo ""
fi

# PASO 3: Ejecutar contenedor
echo "⏳ PASO 3: Ejecutando contenedor..."
echo ""

CONTENEDOR_ID=$(docker run -d \
    -p 8080:80 \
    --name hola-mundo-app \
    --restart unless-stopped \
    hola-mundo-app:latest)

if [ -z "$CONTENEDOR_ID" ]; then
    echo "❌ Error al ejecutar el contenedor"
    exit 1
fi

echo "✅ Contenedor ejecutado: $CONTENEDOR_ID"
echo ""

# PASO 4: Esperar a que esté listo
echo "⏳ Esperando a que el contenedor esté listo..."
sleep 2

# PASO 5: Verificar
echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║              VERIFICACIÓN FINAL                        ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

# Ver si está corriendo
if docker ps --filter "name=hola-mundo-app" --quiet | grep -q .; then
    echo "✅ Contenedor está corriendo"
    echo ""
    echo "Estado del contenedor:"
    docker ps --filter "name=hola-mundo-app" --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}"
else
    echo "❌ Error: Contenedor no está corriendo"
    docker logs hola-mundo-app
    exit 1
fi

echo ""
echo "✅ Ver logs:"
echo "   docker logs -f hola-mundo-app"
echo ""

# Verificar conectividad
echo "⏳ Verificando conectividad..."
if curl -s http://localhost:8080 > /dev/null 2>&1; then
    echo "✅ Servidor responde en http://localhost:8080"
else
    echo "⚠️  Esperando a que el servidor inicie..."
    sleep 2
    if curl -s http://localhost:8080 > /dev/null 2>&1; then
        echo "✅ Servidor responde en http://localhost:8080"
    else
        echo "⚠️  No se puede conectar aún (intenta esperar unos segundos)"
    fi
fi

echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║              ✅ INSTALACIÓN COMPLETADA                 ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""
echo "🌐 Accede a: http://localhost:8080"
echo ""
echo "📋 Comandos útiles:"
echo "   docker ps                         - Ver contenedores"
echo "   docker logs -f hola-mundo-app     - Ver logs en vivo"
echo "   docker stop hola-mundo-app        - Detener"
echo "   docker restart hola-mundo-app     - Reiniciar"
echo "   docker rm hola-mundo-app          - Eliminar contenedor"
echo ""
