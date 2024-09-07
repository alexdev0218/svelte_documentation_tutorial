# Etapa de construcción
FROM node:22.6.0-alpine AS build

# Establece el directorio de trabajo en la imagen
WORKDIR /app

# Copia los archivos del proyecto al contenedor
COPY package*.json ./
COPY . .

# Instala las dependencias y construye la aplicación
RUN npm install
RUN npm run build

# Etapa de producción
FROM nginx:stable-alpine3.20

# Copia los archivos construidos desde la etapa de construcción a la carpeta de Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Copia el archivo de configuración de Nginx si necesitas configuraciones personalizadas (opcional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expone el puerto 80
EXPOSE 80

# Comando para ejecutar Nginx
CMD ["nginx", "-g", "daemon off;"]
