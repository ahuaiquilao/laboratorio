# Makefile - Automatización de Docker

.PHONY: help build run stop restart clean logs

help:
	@echo "╔════════════════════════════════════════════════════════╗"
	@echo "║         COMANDOS DISPONIBLES - Makefile                ║"
	@echo "╚════════════════════════════════════════════════════════╝"
	@echo ""
	@echo "Instalación:"
	@echo "  make install      - Construir e instalar en Docker"
	@echo "  make build        - Solo construir imagen"
	@echo "  make run          - Solo ejecutar contenedor"
	@echo ""
	@echo "Gestión:"
	@echo "  make logs         - Ver logs en tiempo real"
	@echo "  make stop         - Detener contenedor"
	@echo "  make restart      - Reiniciar contenedor"
	@echo "  make clean        - Eliminar contenedor e imagen"
	@echo ""
	@echo "Utilidades:"
	@echo "  make ps           - Ver contenedor"
	@echo "  make status       - Ver estado completo"
	@echo "  make help         - Mostrar este mensaje"
	@echo ""

install: build run status

build:
	@echo "⏳ Construyendo imagen..."
	docker build -t hola-mundo-app:latest .
	@echo "✅ Imagen construida"

run:
	@echo "⏳ Verificando contenedor anterior..."
	@docker stop hola-mundo-app 2>/dev/null || true
	@docker rm hola-mundo-app 2>/dev/null || true
	@echo "⏳ Ejecutando contenedor..."
	docker run -d \
		-p 8080:80 \
		--name hola-mundo-app \
		--restart unless-stopped \
		hola-mundo-app:latest
	@sleep 2
	@echo "✅ Contenedor ejecutado"

logs:
	docker logs -f hola-mundo-app

stop:
	@echo "⏳ Deteniendo contenedor..."
	docker stop hola-mundo-app
	@echo "✅ Contenedor detenido"

restart:
	@echo "⏳ Reiniciando contenedor..."
	docker restart hola-mundo-app
	@echo "✅ Contenedor reiniciado"

clean:
	@echo "⏳ Eliminando contenedor..."
	@docker stop hola-mundo-app 2>/dev/null || true
	@docker rm hola-mundo-app 2>/dev/null || true
	@echo "⏳ Eliminando imagen..."
	@docker rmi hola-mundo-app:latest 2>/dev/null || true
	@echo "✅ Limpieza completada"

ps:
	docker ps --filter "name=hola-mundo-app"

status:
	@echo "╔════════════════════════════════════════════════════════╗"
	@echo "║                  ESTADO DEL SISTEMA                    ║"
	@echo "╚════════════════════════════════════════════════════════╝"
	@echo ""
	@echo "📦 Contenedor:"
	@docker ps -a --filter "name=hola-mundo-app" || echo "  No hay contenedor"
	@echo ""
	@echo "🖼️  Imagen:"
	@docker images hola-mundo-app || echo "  No hay imagen"
	@echo ""
	@echo "🌐 Acceso:"
	@echo "  http://localhost:8080"
	@echo ""

# Alias útiles
build-run: build run
fresh: clean install
