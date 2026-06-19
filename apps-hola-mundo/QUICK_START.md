# ⚡ REFERENCIA RÁPIDA - DOCKER

## 🚀 ACCESO INMEDIATO

```bash
# La app ya está corriendo en:
http://localhost:8080
```

---

## 🎯 COMANDOS FRECUENTES

### **Ver que está corriendo**
```bash
docker ps
```

### **Ver logs**
```bash
docker logs -f hola-mundo-app
```

### **Reiniciar**
```bash
docker-compose restart
```

### **Detener**
```bash
docker-compose down
```

### **Iniciar de nuevo**
```bash
docker-compose up -d
```

---

## 📁 ARCHIVOS PRINCIPALES

```
Dockerfile          ← Cómo construir la imagen
nginx.conf          ← Cómo servir la app
docker-compose.yml  ← Cómo ejecutar
.dockerignore       ← Qué no incluir
DOCKER.md           ← Documentación completa
DOCKER_PASO_A_PASO.md ← Explicación detallada
```

---

## 📊 ESTADO ACTUAL

| Propiedad | Valor |
|-----------|-------|
| Contenedor | ✅ Corriendo |
| Puerto | 8080 |
| Estado HTTP | 200 OK |
| Imagen | 102 MB |
| Servidor | Nginx |
| Modo | Producción |

---

## 🔧 CAMBIAR PUERTO

**Edita `docker-compose.yml`:**
```yaml
ports:
  - "8000:80"  # Cambiar primer número
```

**Luego:**
```bash
docker-compose down
docker-compose up -d
```

Accede a: `http://localhost:8000`

---

## 🛠️ TROUBLESHOOTING

### Puerto en uso
```bash
lsof -ti:8080 | xargs kill -9
docker-compose up -d
```

### Reconstruir imagen
```bash
docker-compose down
docker-compose up -d --build
```

### Logs completos
```bash
docker logs hola-mundo-app | head -50
```

---

## 📚 DOCUMENTACIÓN

- **Principiante**: [DOCKER_PASO_A_PASO.md](DOCKER_PASO_A_PASO.md)
- **Usuario**: [DOCKER.md](DOCKER.md)
- **Resumen**: [RESUMEN_DOCKER.md](RESUMEN_DOCKER.md)
- **General**: [GUIA.md](GUIA.md)

---

**¡Aplicación lista! 🚀**
