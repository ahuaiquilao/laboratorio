# 📦 INSTALACIÓN MANUAL DE LA APLICACIÓN EN DOCKER

Guía completa paso a paso para instalar y ejecutar la aplicación Angular en Docker sin usar `docker-compose`.

---

## 🎯 REQUISITOS PREVIOS

Verifica que tengas Docker instalado:

```bash
docker --version
```

**Output esperado:**
```
Docker version 27.0.0, build c9f0d67
```

Si no lo tienes, descarga desde: https://www.docker.com/products/docker-desktop

---

## 📋 PASO A PASO MANUAL

### **PASO 1: Navegar al directorio del proyecto**

```bash
cd /Users/yastamiro/Personal/Adrian/Laboratorio/apps-hola-mundo
```

**Qué hace:** Te posiciona en la carpeta del proyecto

**Verificación:**
```bash
ls -la
```

Deberías ver:
```
Dockerfile
nginx.conf
.dockerignore
docker-compose.yml
src/
angular.json
package.json
```

---

### **PASO 2: Construir la imagen Docker**

```bash
docker build -t hola-mundo-app:latest .
```

**Qué hace:**
- Lee el `Dockerfile`
- Descarga Node.js 22-Alpine
- Instala dependencias npm
- Compila la aplicación
- Descarga Nginx Alpine
- Empaqueta todo en una imagen

**Output esperado:**
```
[+] Building 41.6s (20/20) FINISHED
 => [internal] load build definition from Dockerfile
 => [builder 6/9] RUN npm install                   18.9s
 => [builder 9/9] RUN npm run build                  8.2s
 => naming to docker.io/library/hola-mundo-app:latest
```

**Tiempo:** 40-50 segundos (primera vez)

---

### **PASO 3: Verificar que la imagen se creó**

```bash
docker images | grep hola-mundo-app
```

**Output esperado:**
```
REPOSITORY          TAG       IMAGE ID        SIZE
hola-mundo-app      latest    bc5174acfbc6    102MB
```

---

### **PASO 4: Crear y ejecutar el contenedor**

```bash
docker run -d \
  -p 8080:80 \
  --name hola-mundo-app \
  hola-mundo-app:latest
```

**Desglose del comando:**
- `docker run` - Crear y ejecutar contenedor
- `-d` - Ejecutar en segundo plano
- `-p 8080:80` - Puerto local 8080 → Puerto contenedor 80
- `--name hola-mundo-app` - Nombre del contenedor
- `hola-mundo-app:latest` - Imagen a usar

**Output esperado:**
```
8a441f932408d7c5e3f5c2b1a9d6e4f3
```

(ID del contenedor - confirma que se creó)

---

### **PASO 5: Verificar que el contenedor está corriendo**

```bash
docker ps
```

**Output esperado:**
```
CONTAINER ID   IMAGE                NAME             STATUS      PORTS
8a441f932408   hola-mundo-app:l..   hola-mundo-app   Up 5s       0.0.0.0:8080->80/tcp
```

---

### **PASO 6: Ver los logs (opcional)**

```bash
docker logs hola-mundo-app
```

**Output esperado:**
```
2026/06/19 18:04:30 [notice] 1#1: signal process started
nginx: master process master process
```

---

### **PASO 7: Probar la conexión**

```bash
curl http://localhost:8080
```

**Output esperado:**
```
<!doctype html>
<html lang="en" data-beasties-container>
<head>
  <meta charset="utf-8">
  <title>AppsHolaMundo</title>
  ...
```

(Primeras líneas del HTML de tu aplicación)

---

### **PASO 8: Acceder en el navegador**

Abre tu navegador y ve a:

```
http://localhost:8080
```

✅ **¡Verás tu aplicación Angular ejecutándose!**

---

## 🎮 OPERACIONES COMUNES

### **Ver estado del contenedor**

```bash
docker ps -a
```

### **Ver logs en tiempo real**

```bash
docker logs -f hola-mundo-app
```

(Presiona `Ctrl+C` para salir)

### **Detener el contenedor**

```bash
docker stop hola-mundo-app
```

### **Reiniciar el contenedor**

```bash
docker restart hola-mundo-app
```

### **Iniciar un contenedor detenido**

```bash
docker start hola-mundo-app
```

### **Entrar al contenedor (terminal)**

```bash
docker exec -it hola-mundo-app /bin/sh
```

(Para salir, escribe `exit`)

---

## 🗑️ ELIMINAR TODO

### **Eliminar contenedor**

```bash
docker stop hola-mundo-app
docker rm hola-mundo-app
```

### **Eliminar imagen**

```bash
docker rmi hola-mundo-app:latest
```

### **Eliminar todo de una vez**

```bash
docker stop hola-mundo-app && \
docker rm hola-mundo-app && \
docker rmi hola-mundo-app:latest
```

---

## 📊 TODOS LOS COMANDOS EN ORDEN

### **Instalación Completa (Copiar y pegar)**

```bash
# 1. Navegar al proyecto
cd /Users/yastamiro/Personal/Adrian/Laboratorio/apps-hola-mundo

# 2. Construir imagen
docker build -t hola-mundo-app:latest .

# 3. Ejecutar contenedor
docker run -d \
  -p 8080:80 \
  --name hola-mundo-app \
  hola-mundo-app:latest

# 4. Verificar
docker ps

# 5. Ver logs
docker logs hola-mundo-app
```

---

## 🔧 VARIACIONES Y OPCIONES

### **Cambiar puerto (ejemplo: 8000)**

```bash
docker run -d \
  -p 8000:80 \
  --name hola-mundo-app \
  hola-mundo-app:latest
```

Accede a: `http://localhost:8000`

---

### **Ejecutar en primer plano (sin -d)**

```bash
docker run -p 8080:80 \
  --name hola-mundo-app \
  hola-mundo-app:latest
```

Ver logs en tiempo real y presiona `Ctrl+C` para detener

---

### **Ejecutar con variables de entorno**

```bash
docker run -d \
  -p 8080:80 \
  --name hola-mundo-app \
  -e NODE_ENV=production \
  hola-mundo-app:latest
```

---

### **Ejecutar con reinicio automático**

```bash
docker run -d \
  -p 8080:80 \
  --name hola-mundo-app \
  --restart unless-stopped \
  hola-mundo-app:latest
```

(Se reinicia automáticamente si se detiene)

---

### **Ejecutar con límite de memoria**

```bash
docker run -d \
  -p 8080:80 \
  --name hola-mundo-app \
  -m 512m \
  hola-mundo-app:latest
```

(Máximo 512 MB de memoria)

---

## 📚 EXPLICACIÓN DEL DOCKERFILE

El `Dockerfile` hace esto:

```dockerfile
# Stage 1: Compilar la app
FROM node:22-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY src ./src
COPY public ./public
RUN npm run build --production

# Stage 2: Servir con Nginx
FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/dist/apps-hola-mundo/browser /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

**Resultado:** Imagen de 102 MB lista para producción

---

## 🎯 RESUMEN RÁPIDO

| Paso | Comando |
|------|---------|
| 1 | `cd .../apps-hola-mundo` |
| 2 | `docker build -t hola-mundo-app:latest .` |
| 3 | `docker run -d -p 8080:80 --name hola-mundo-app hola-mundo-app:latest` |
| 4 | Abre `http://localhost:8080` |

---

## ✅ VERIFICACIÓN FINAL

Después de ejecutar todos los pasos, verifica:

```bash
# 1. ¿Existe el contenedor?
docker ps | grep hola-mundo-app

# 2. ¿Está corriendo?
docker logs hola-mundo-app

# 3. ¿Responde en el puerto?
curl -I http://localhost:8080

# 4. ¿Muestra el HTML?
curl http://localhost:8080 | head -20
```

---

## 🐛 SOLUCIONAR PROBLEMAS

### **"docker: command not found"**
```bash
# Reinstala Docker Desktop desde https://www.docker.com/
# Reinicia tu terminal
```

### **"Port 8080 already in use"**
```bash
# Usa otro puerto
docker run -d -p 8000:80 --name hola-mundo-app hola-mundo-app:latest

# O mata el proceso en el puerto
lsof -ti:8080 | xargs kill -9
```

### **"image not found"**
```bash
# Reconstruye la imagen
docker build -t hola-mundo-app:latest .
```

### **"Container already exists"**
```bash
# Elimina el contenedor anterior
docker rm hola-mundo-app

# Luego crea uno nuevo
docker run -d -p 8080:80 --name hola-mundo-app hola-mundo-app:latest
```

### **"Connection refused"**
```bash
# Verifica que el contenedor está corriendo
docker ps

# Ver logs
docker logs hola-mundo-app

# Probar localmente
docker exec hola-mundo-app curl localhost:80
```

---

## 📝 NOTAS IMPORTANTES

✅ **Todo está en el proyecto:**
- `Dockerfile` - Receta para la imagen
- `nginx.conf` - Configuración del servidor
- `.dockerignore` - Archivos a excluir

✅ **Sin docker-compose:**
- Usas comandos `docker` directamente
- Más control manual
- Ideal para entender cómo funciona

✅ **Ventajas:**
- Entiendes cada paso
- Controlas los parámetros
- Fácil de automatizar

---

## 🎓 COMPARACIÓN: docker-compose vs manual

| Aspecto | docker-compose | Manual (docker run) |
|---------|---|---|
| **Comando** | `docker-compose up -d` | `docker run -d ...` |
| **Configuración** | En archivo YAML | En línea de comandos |
| **Complejidad** | Más simple (múltiples servicios) | Más explícito |
| **Red** | Automática | Manual (--network) |
| **Volúmenes** | Definidos en compose | Con -v |

---

**¡Ahora sabes cómo instalar Docker manualmente!** 🐳
