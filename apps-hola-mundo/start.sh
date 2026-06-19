#!/bin/bash

# Script para ejecutar la aplicación Angular Hola Mundo

echo "=========================================="
echo "    Hola Mundo App - Angular"
echo "=========================================="
echo ""

# Verificar si node_modules existe
if [ ! -d "node_modules" ]; then
    echo "📦 Instalando dependencias..."
    npm install
fi

echo ""
echo "🚀 Iniciando servidor de desarrollo..."
echo "   La aplicación estará disponible en: http://localhost:4200"
echo ""
echo "Presiona Ctrl+C para detener el servidor"
echo ""

ng serve --open
