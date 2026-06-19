# 📦 GUÍA PASO A PASO: DOCKERIZAR LA APLICACIÓN ANGULAR

## ✅ Resumen de lo que se realizó

Tu aplicación Angular "Hola Mundo" está ahora **containerizada con Docker** y ejecutándose en tu máquina local.

### Estado Actual
- ✅ Imagen Docker construida: **102 MB**
- ✅ Contenedor ejecutándose en puerto: **8080**
- ✅ Servidor: **Nginx (producción)**
- ✅ URL de acceso: http://localhost:8080

---

## 📋 PASO A PASO: CÓMO SE HIZO

### **PASO 1️⃣: Archivos Creados**

Se crearon **5 archivos nuevos** en el raíz del proyecto:

#### **a) Dockerfile** (703 bytes)
```dockerfile
# Multistage build - 2 etapas
Stage 1: Builder (Node.js + Compilación)
└─ Instala dependencias
└─ Compila la app para producción

Stage 2: Runtime (Nginx + Distribución)
└─ Sirve los archivos compilados
└─ Expone puerto 80
```

**Propósito:** Define cómo se construye y ejecuta la aplicación en Docker.

---

#### **b) nginx.conf** (1.6 KB)
Configuración de Nginx con:
- ✅ Compresión GZIP
- ✅ Caché inteligente
- ✅ Reescritura de URLs (importante para SPA Angular)
- ✅ Servicio en puerto 80

**Propósito:** Configura cómo Nginx sirve la aplicación.

---

#### **c) docker-compose.yml** (317 bytes)
```yaml
services:
  hola-mundo-app:
    build: .
    ports: ["8080:80"]        # Puerto local → Puerto contenedor
    restart: unless-stopped   # Reinicia automáticamente
    networks:
      - app-network
```

**Propósito:** Orquesta el contenedor con una configuración simple.

---

#### **d) .dockerignore** (131 bytes)
Lista de archivos/carpetas a **NO incluir** en la imagen:
- `node_modules/` (los dependencias se instalan en el contenedor)
- `dist/` (se compila dentro del contenedor)
- `.git/`, `.vscode/`, etc.

**Propósito:** Reduce el tamaño de la imagen.

---

#### **e) DOCKER.md** (4.8 KB)
Documentación completa sobre cómo usar Docker.

---

### **PASO 2️⃣: Construir la Imagen**

```bash
docker build -t hola-mundo-app:latest .
```

**Qué hace:**
1. Lee el `Dockerfile`
2. Descarga imágenes base:
   - `node:22-alpine` (52.31 MB) → Para compilar
   - `nginx:alpine` (20.30 MB) → Para servir
3. **Etapa 1 - Builder:**
   - Copia `package.json`
   - Ejecuta `npm install` (18.9 segundos)
   - Copia código fuente
   - Ejecuta `npm run build` (8.2 segundos)
4. **Etapa 2 - Runtime:**
   - Copia archivos compilados a Nginx
   - Copia configuración `nginx.conf`
5. Crea imagen final: **102 MB** (muy pequeña)

**Resultado:**
```
✔ Image created: hola-mundo-app:latest
```

---

### **PASO 3️⃣: Ejecutar el Contenedor**

```bash
docker-compose up -d
```

**Qué hace:**
1. Lee `docker-compose.yml`
2. Construye la imagen (usa caché si existe)
3. Crea un contenedor llamado `hola-mundo-app`
4. Lo ejecuta en segundo plano (`-d`)
5. Mapea puerto 8080 (tu PC) → 80 (contenedor)

**Resultado:**
```
CONTAINER ID: b5b5637f4eb3
STATUS: Up (corriendo)
PORTS: 0.0.0.0:8080->80/tcp
```

---

### **PASO 4️⃣: Acceder a la Aplicación**

Abre en tu navegador:
```
http://localhost:8080
```

✅ **¡La aplicación está corriendo!**

---

## 🎯 ARQUITECTURA DE DOCKER

```
Tu Computadora
│
├─ Puerto 8080 (Local)
│  │
│  └─ Docker Container
│     ├─ Nginx (Puerto 80)
│     └─ Aplicación Angular compilada
│        ├── index.html
│        ├── main.js (1.3 MB minificado)
│        ├── styles.css
│        └── assets/
```

---

## 📊 COMPARACIÓN: Local vs Docker

| Aspecto | Local | Docker |
|---------|-------|--------|
| **Servidor** | Vite Dev Server | Nginx |
| **Puerto** | 4200 | 8080 |
| **Recarga** | Auto (HMR) | Manual |
| **Modo** | Desarrollo | Producción |
| **Node.js** | Tu PC | Contenedor |
| **Aislamiento** | Ninguno | Completo |

---

## 🚀 COMANDOS PRINCIPALES

### **Verificar que está corriendo**
```bash
docker ps
```
Output:
```
CONTAINER ID   IMAGE                NAME             PORTS
b5b5637f4eb3   hola-mundo-app:l..   hola-mundo-app   0.0.0.0:8080->80/tcp
```

### **Ver logs en tiempo real**
```bash
docker logs -f hola-mundo-app
```

### **Detener el contenedor**
```bash
docker stop hola-mundo-app
# O con docker-compose
docker-compose down
```

### **Reiniciar**
```bash
docker restart hola-mundo-app
# O con docker-compose
docker-compose restart
```

### **Ver tamaño de la imagen**
```bash
docker images hola-mundo-app
```
Resultado: **102 MB** (muy compacta)

### **Eliminar contenedor y imagen**
```bash
docker-compose down --rmi all
# O manual
docker stop hola-mundo-app
docker rm hola-mundo-app
docker rmi hola-mundo-app:latest
```

---

## 🔧 PERSONALIZAR LA CONFIGURACIÓN

### **Cambiar puerto**
Edita `docker-compose.yml`:
```yaml
ports:
  - "8000:80"  # Cambiar a 8000
```

Luego:
```bash
docker-compose down
docker-compose up -d
```

Accede a: `http://localhost:8000`

### **Cambiar nombre del contenedor**
Edita `docker-compose.yml`:
```yaml
container_name: mi-app
```

### **Agregar variables de entorno**
```yaml
environment:
  - NODE_ENV=production
  - API_URL=https://api.ejemplo.com
```

---

## 🐛 SOLUCIONAR PROBLEMAS

### ❌ "docker: command not found"
**Solución:** Reinstala Docker Desktop desde https://www.docker.com/products/docker-desktop

### ❌ "Port 8080 already in use"
**Solución:** Cambia el puerto en `docker-compose.yml` o:
```bash
lsof -ti:8080 | xargs kill -9
```

### ❌ "Container exits immediately"
**Solución:** Ver logs:
```bash
docker logs hola-mundo-app
```

### ❌ "Nginx connection refused"
**Solución:**
```bash
docker exec hola-mundo-app ps aux  # Ver procesos
docker exec hola-mundo-app curl localhost:80  # Probar localmente
```

---

## 📦 ESTRUCTURA DE ARCHIVOS FINALES

```
apps-hola-mundo/
├── src/                      # Código fuente TypeScript/Angular
│   ├── app/
│   ├── main.ts
│   ├── styles.css
│   └── index.html
├── public/
├── dist/                     # Compilado (generado en build)
├── node_modules/             # Dependencias (local y en Docker)
│
├── Dockerfile                ← NUEVO: Define la imagen
├── nginx.conf                ← NUEVO: Configuración web
├── docker-compose.yml        ← NUEVO: Orquestación
├── .dockerignore             ← NUEVO: Archivos a excluir
│
├── GUIA.md                   # Guía de uso local
├── DOCKER.md                 # Guía de Docker
├── start.sh                  # Script para ejecutar local
├── package.json
├── angular.json
└── README.md
```

---

## 🎓 APRENDER MÁS

### **Conceptos clave:**
- **Docker Image:** Plantilla (como un programa empaquetado)
- **Docker Container:** Instancia en ejecución (como correr un programa)
- **Dockerfile:** Receta para crear la imagen
- **docker-compose:** Herramienta para orquestar múltiples contenedores
- **Nginx:** Servidor web ligero

### **Comandos Docker esenciales:**
```bash
docker build     # Construir imagen
docker run       # Ejecutar contenedor
docker ps        # Listar contenedores activos
docker logs      # Ver logs
docker exec      # Ejecutar comando dentro del contenedor
docker-compose   # Orquestar con archivos YAML
```

---

## ✨ VENTAJAS DE USAR DOCKER

✅ **Consistencia:** Funciona igual en tu PC, en producción, en otros desarrolladores  
✅ **Aislamiento:** No afecta otras aplicaciones  
✅ **Facilidad:** "Funciona en mi Docker" = Funciona en cualquier lugar  
✅ **Escalabilidad:** Fácil de desplegar en la nube (AWS, Azure, GCP)  
✅ **DevOps:** Automatiza despliegues  

---

## 🎯 PRÓXIMOS PASOS

### Opción 1: Desplegar a la Nube
```bash
# AWS
aws ecr get-login-password | docker login --username AWS --password-stdin <cuenta>.dkr.ecr.us-east-1.amazonaws.com
docker tag hola-mundo-app <cuenta>.dkr.ecr.us-east-1.amazonaws.com/hola-mundo-app
docker push <cuenta>.dkr.ecr.us-east-1.amazonaws.com/hola-mundo-app

# Heroku
heroku container:push web
heroku container:release web
```

### Opción 2: Publicar en Docker Hub
```bash
docker login
docker tag hola-mundo-app:latest tu-usuario/hola-mundo-app:latest
docker push tu-usuario/hola-mundo-app:latest
```

### Opción 3: Agregar Base de Datos
```yaml
services:
  app:
    # ... config actual
  postgres:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: password
```

---

## 🎉 ¡RESUMEN!

| Paso | Comando | Resultado |
|------|---------|-----------|
| 1️⃣ Construir | `docker build -t hola-mundo-app:latest .` | Imagen creada (102 MB) |
| 2️⃣ Ejecutar | `docker-compose up -d` | Contenedor corriendo |
| 3️⃣ Acceder | Abrir `http://localhost:8080` | ¡App visible! |
| 4️⃣ Detener | `docker-compose down` | Contenedor detenido |

**Tu aplicación Angular está completamente containerizada y lista para producción** 🚀

---

**Archivos clave creados:**
- ✅ [Dockerfile](Dockerfile) - Construcción
- ✅ [nginx.conf](nginx.conf) - Configuración web
- ✅ [docker-compose.yml](docker-compose.yml) - Orquestación
- ✅ [.dockerignore](.dockerignore) - Exclusiones
- ✅ [DOCKER.md](DOCKER.md) - Documentación completa

**Para más detalles, revisa [DOCKER.md](DOCKER.md)**
