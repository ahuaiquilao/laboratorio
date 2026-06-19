# 🗑️ GUÍA PASO A PASO: Eliminar Contenedor e Imagen Docker

## ✅ ESTADO ACTUAL

- ✅ **Contenedor**: Eliminado
- ✅ **Imagen**: Eliminada
- ✅ **Red Docker**: Eliminada

---

## 📋 PASO A PASO PARA HACERLO MANUALMENTE

### **PASO 1: Ubicarte en el directorio del proyecto**

```bash
cd /Users/yastamiro/Personal/Adrian/Laboratorio/apps-hola-mundo
```

**Qué hace:** Te posiciona en la carpeta donde está el `docker-compose.yml`

---

### **PASO 2: Detener y eliminar el contenedor con docker-compose**

```bash
docker-compose down
```

**Qué hace:**
- ✅ Detiene el contenedor `hola-mundo-app`
- ✅ Elimina la red `app-network`
- ❌ NO elimina la imagen (necesitas el paso 3)

**Output esperado:**
```
[+] down 1/1
 ✔ Network apps-hola-mundo_app-network Removed
```

---

### **PASO 3: Ver las imágenes disponibles**

```bash
docker images | grep hola-mundo
```

**Qué hace:** Lista todas las imágenes relacionadas con "hola-mundo"

**Output esperado (Antes de eliminar):**
```
REPOSITORY                          TAG       IMAGE ID        SIZE
hola-mundo-app                      latest    bc5174acfbc6    102MB
apps-hola-mundo-hola-mundo-app      latest    bc5174acfbc6    102MB
```

---

### **PASO 4: Eliminar las imágenes**

#### **Opción A: Eliminar por nombre (Recomendado)**

```bash
docker rmi hola-mundo-app:latest
```

**Qué hace:** Elimina la imagen `hola-mundo-app`

**Output esperado:**
```
Untagged: hola-mundo-app:latest
Deleted: sha256:bc5174acfbc6...
```

---

#### **Opción B: Eliminar por ID de imagen**

Si hay múltiples versiones:

```bash
docker rmi bc5174acfbc6
```

**Qué hace:** Elimina la imagen usando su ID único

---

#### **Opción C: Eliminar TODO de una vez (Fuerza)**

```bash
docker rmi -f $(docker images | grep hola-mundo | awk '{print $3}')
```

**Qué hace:**
- Encuentra todas las imágenes con "hola-mundo"
- Extrae sus IDs
- Las elimina todas con fuerza (`-f`)

---

### **PASO 5: Verificar que se eliminó todo**

```bash
docker ps -a | grep hola-mundo
```

**Qué hace:** Lista contenedores detenidos

**Output esperado:**
```
(sin resultados) ✅
```

---

```bash
docker images | grep hola-mundo
```

**Qué hace:** Lista todas las imágenes

**Output esperado:**
```
(sin resultados) ✅
```

---

## 🎯 MÉTODO COMPLETO (TODO EN UNO)

Si quieres hacerlo todo junto:

```bash
# Ir al directorio
cd /Users/yastamiro/Personal/Adrian/Laboratorio/apps-hola-mundo

# Detener todo
docker-compose down

# Eliminar imagen
docker rmi hola-mundo-app:latest

# Verificar
docker ps -a
docker images
```

---

## 📊 COMPARACIÓN: ANTES vs DESPUÉS

### **ANTES (Imagen ejecutándose)**

```bash
$ docker ps
CONTAINER ID   IMAGE              STATUS      PORTS
8a441f932408   hola-mundo-app     Up 2 days   0.0.0.0:8080->80/tcp

$ docker images
REPOSITORY          SIZE
hola-mundo-app      102MB
```

### **DESPUÉS (Completamente eliminado)**

```bash
$ docker ps
(sin contenedores)

$ docker images
(sin imágenes de hola-mundo)
```

---

## 🗑️ TIPOS DE ELIMINACIÓN

| Comando | Qué elimina | Qué NO elimina |
|---------|-------------|------------------|
| `docker stop` | Detiene el contenedor | Imagen, Red |
| `docker rm` | Elimina contenedor detenido | Imagen |
| `docker rmi` | Elimina imagen | Código fuente |
| `docker-compose down` | Contenedor + Red | Imagen |
| `docker-compose down --rmi all` | Todo | Código fuente |
| `docker system prune -a` | TODO sin usar | Código fuente |

---

## ⚠️ PRECAUCIONES

### **No se elimina:**
- ❌ El código fuente (carpeta `src/`)
- ❌ Los archivos de configuración (`Dockerfile`, etc.)
- ❌ La carpeta del proyecto

### **Se conserva:**
- ✅ `Dockerfile`
- ✅ `nginx.conf`
- ✅ `docker-compose.yml`
- ✅ Código fuente
- ✅ `package.json`, `angular.json`, etc.

**Puedes reconstruir todo nuevamente ejecutando:**
```bash
docker-compose up -d --build
```

---

## 🔄 RECUPERAR LA APLICACIÓN

Después de eliminar, si quieres volver a ejecutarla:

### **Opción 1: Reconstruir desde cero**
```bash
docker-compose up -d --build
```

### **Opción 2: Desde caché (más rápido)**
```bash
docker-compose up -d
```

---

## 📝 COMANDOS ÚTILES ADICIONALES

### **Ver todos los contenedores (incluyendo detenidos)**
```bash
docker ps -a
```

### **Ver todas las imágenes**
```bash
docker images
```

### **Eliminar contenedores detenidos**
```bash
docker container prune
```

### **Eliminar imágenes no usadas**
```bash
docker image prune
```

### **Limpiar TODO de Docker**
```bash
docker system prune -a
```

---

## ✅ CHECKLIST DE ELIMINACIÓN

Antes de eliminar, verifica:

- [ ] No hay datos importantes en el contenedor
- [ ] No hay volúmenes con datos críticos
- [ ] Tienes el código fuente guardado localmente
- [ ] Tienes backups si es necesario

Después de eliminar, verifica:

- [ ] No aparece en `docker ps -a`
- [ ] No aparece en `docker images`
- [ ] Los archivos del proyecto siguen intactos
- [ ] Puedes reconstruir ejecutando `docker-compose up -d --build`

---

## 🎓 REFERENCIA RÁPIDA

```bash
# VER
docker ps                      # Contenedores activos
docker ps -a                   # Todos los contenedores
docker images                  # Todas las imágenes
docker logs hola-mundo-app     # Ver logs

# DETENER
docker stop hola-mundo-app     # Detener contenedor
docker-compose down            # Detener con compose

# ELIMINAR
docker rm hola-mundo-app       # Eliminar contenedor
docker rmi imagen-id           # Eliminar imagen
docker-compose down --rmi all  # Eliminar todo

# VERIFICAR
docker ps -a | grep hola-mundo
docker images | grep hola-mundo
```

---

**¡Listo! Ahora sabes cómo eliminar contenedores e imágenes Docker manualmente.** 🗑️
