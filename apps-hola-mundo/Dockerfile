# Stage 1: Build
FROM node:22-alpine AS builder

WORKDIR /app

# Copiar archivos de configuración
COPY package*.json ./
COPY angular.json ./
COPY tsconfig*.json ./

# Instalar dependencias
RUN npm install

# Copiar código fuente
COPY src ./src
COPY public ./public

# Compilar la aplicación para producción
RUN npm run build -- --configuration production

# Stage 2: Nginx (servir la aplicación)
FROM nginx:alpine

# Copiar configuración de Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Limpiar directorio default de Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copiar archivos compilados desde stage anterior (contenido del browser/)
COPY --from=builder /app/dist/apps-hola-mundo/browser /usr/share/nginx/html

# Exponer puerto
EXPOSE 80

# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
