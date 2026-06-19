# Hola Mundo App - Aplicación Angular Profesional

Una aplicación web moderna construida con Angular que sigue mejores prácticas y una estructura profesional.

## Estructura del Proyecto

```
src/
├── app/
│   ├── layout/
│   │   ├── header/          # Componente de encabezado
│   │   └── footer/          # Componente de pie de página
│   ├── features/
│   │   └── home/            # Componente principal (Hola Mundo)
│   ├── app.ts               # Componente raíz
│   ├── app.html             # Template principal
│   ├── app.css              # Estilos del componente raíz
│   └── app.routes.ts        # Rutas de la aplicación
├── main.ts                  # Punto de entrada
├── styles.css               # Estilos globales
└── index.html               # Archivo HTML principal
```

## Características

✨ **Hola Mundo** - Mensaje de bienvenida con estilo  
🚀 **Rendimiento Optimizado** - Compilación y carga rápida  
🎨 **Diseño Moderno** - Interfaz limpia y atractiva con gradientes  
📱 **Responsivo** - Funciona perfectamente en cualquier dispositivo  
🔧 **Estructura Profesional** - Componentes separados y bien organizados  

## Requisitos

- Node.js (v18 o superior)
- npm (incluido con Node.js)

## Instalación

La aplicación ya está instalada. Para verificar:

```bash
cd /Users/yastamiro/Personal/Adrian/Laboratorio/apps-hola-mundo
```

## Ejecución

### Modo Desarrollo
```bash
ng serve
# o
npm start
```
Luego accede a `http://localhost:4200`

### Compilación para Producción
```bash
ng build --configuration production
```

### Ejecución de Tests
```bash
ng test
```

## Componentes Principales

### Header (Encabezado)
- Logo/Título de la aplicación
- Navegación principal
- Estilos con gradiente

### Home (Principal)
- Mensaje "¡Hola Mundo!"
- Sección de características
- Botón de llamada a la acción
- Animaciones suaves

### Footer (Pie de Página)
- Derechos de autor
- Enlaces de navegación secundaria
- Información legal

## Estilos

- **Gradiente Principal**: De #667eea a #764ba2
- **Tipografía**: Segoe UI con fallbacks
- **Responsive**: Breakpoint en 768px
- **Animaciones**: Fade-in y slide-up

## Recursos

- [Angular Documentation](https://angular.dev)
- [Angular CLI](https://angular.dev/tools/cli)
- [TypeScript](https://www.typescriptlang.org/)

## Desarrollo

El proyecto está listo para desarrollo. Para agregar nuevos componentes:

```bash
ng generate component features/nuevo-componente
ng generate service services/mi-servicio
```

## Licencia

Este proyecto es de código abierto y está disponible bajo licencia MIT.
