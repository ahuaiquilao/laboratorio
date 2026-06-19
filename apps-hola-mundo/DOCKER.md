# Dockerización de Hola Mundo App

Guía completa para ejecutar la aplicación Angular en Docker.

## 📋 Requisitos

- Docker instalado ([Descargar](https://www.docker.com/products/docker-desktop))
- Docker Compose (incluido con Docker Desktop)

## 📁 Archivos Creados

```
apps-hola-mundo/
├── Dockerfile          # Imagen Docker multistage
├── nginx.conf          # Configuración de Nginx
├── docker-compose.yml  # Orquestación de contenedores
└── .dockerignore       # Archivos a ignorar en la imagen
```

## 🚀 Paso a Paso

### **Paso 1: Verificar Docker está instalado**
```bash
docker --version
docker-compose --version
```

### **Paso 2: Navegar al proyecto**
```bash
cd /Users/yastamiro/Personal/Adrian/Laboratorio/apps-hola-mundo
```

### **Paso 3: Construir la imagen Docker**
```bash
docker build -t hola-mundo-app:latest .
```

**Qué hace:**
- Lee el `Dockerfile`
- Descarga Node.js 22 Alpine (imagen base pequeña)
- Instala dependencias (npm install)
- Compila la app para producción
- Descarga Nginx Alpine
- Prepara la aplicación para servir

### **Paso 4: Ejecutar con Docker**

#### **Opción A: Con docker-compose (Recomendado)**
```bash
docker-compose up
```

**O en segundo plano:**
```bash
docker-compose up -d
```

#### **Opción B: Con docker run (Manual)**
```bash
docker run -d -p 8080:80 --name hola-mundo-app hola-mundo-app:latest
```

### **Paso 5: Acceder a la aplicación**
Abre en tu navegador:
```
http://localhost:8080
```

## 📋 Comandos Docker Útiles

### **Ver si el contenedor está corriendo**
```bash
docker ps
```

### **Ver logs en tiempo real**
```bash
docker logs -f hola-mundo-app
```

### **Detener el contenedor**
```bash
docker-compose down
# O
docker stop hola-mundo-app
```

### **Reiniciar el contenedor**
```bash
docker-compose restart
# O
docker restart hola-mundo-app
```

### **Eliminar la imagen**
```bash
docker rmi hola-mundo-app:latest
```

### **Reconstruir y ejecutar limpio**
```bash
docker-compose down
docker system prune -a
docker-compose up --build
```

## 🏗️ Entender la Arquitectura

### **Dockerfile - Multistage Build**

```
Stage 1: Builder
├── Node.js 22 Alpine (ligero)
├── Instala npm
├── Copia código
└── Compila con: ng build --configuration production

Stage 2: Runtime
├── Nginx Alpine (muy ligero)
├── Copia archivos compilados
└── Sirve en puerto 80
```

**Ventajas:**
- ✅ La imagen final es pequeña (~100MB)
- ✅ No incluye herramientas de build
- ✅ Más segura
- ✅ Más rápida

### **nginx.conf - Configuración Web**

- Compresión GZIP habilitada
- Caché inteligente para archivos estáticos
- Reescritura de URLs (importante para Angular SPA)
- Soporte CORS configurado
- Logs de acceso

### **docker-compose.yml - Orquestación**

```yaml
- Puerto: 8080 (local) → 80 (contenedor)
- Red: app-network
- Reinicio automático
- Variables de entorno
```

## 🔍 Verificar que funciona

```bash
# Ver la imagen creada
docker images | grep hola-mundo-app

# Ver contenedor en ejecución
docker ps | grep hola-mundo-app

# Probar la aplicación
curl http://localhost:8080

# Ver tamaño de la imagen
docker images --format "{{.Repository}} {{.Size}}" | grep hola-mundo-app
```

## 📊 Comparación: Local vs Docker

| Aspecto | Local | Docker |
|---------|-------|--------|
| Dependencias | Node.js en tu PC | Aisladas en contenedor |
| Puerto | 4200 | 8080 |
| Servidor | Vite Dev | Nginx Production |
| Aislamiento | Ninguno | Completo |
| Portabilidad | No | Sí (cualquier máquina) |

## 🐛 Solucionar Problemas

### **"docker command not found"**
- Reinstala Docker Desktop
- Reinicia tu terminal

### **"Port 8080 already in use"**
```bash
# Cambiar puerto en docker-compose.yml
ports:
  - "8081:80"  # Cambiar a 8081

# O matar el proceso
lsof -ti:8080 | xargs kill -9
```

### **Contenedor se detiene inmediatamente**
```bash
docker logs hola-mundo-app
```

### **La app no carga en el navegador**
```bash
# Verificar que está corriendo
docker ps

# Verificar logs
docker logs hola-mundo-app

# Probar conectividad
docker exec hola-mundo-app curl localhost:80
```

## 📦 Publicar a Docker Hub (Opcional)

```bash
# Login
docker login

# Taggear
docker tag hola-mundo-app:latest tu-usuario/hola-mundo-app:latest

# Push
docker push tu-usuario/hola-mundo-app:latest

# Otros pueden descargar con:
docker pull tu-usuario/hola-mundo-app:latest
```

## 🎯 Ejemplo Completo

```bash
# 1. Construir
cd /Users/yastamiro/Personal/Adrian/Laboratorio/apps-hola-mundo
docker build -t hola-mundo-app:latest .

# 2. Ejecutar
docker-compose up -d

# 3. Verificar
docker ps
curl http://localhost:8080

# 4. Ver logs
docker logs -f hola-mundo-app

# 5. Detener (cuando termines)
docker-compose down
```

¡Listo! Tu aplicación Angular está containerizada con Docker. 🐳
