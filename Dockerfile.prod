# Etapa de construcción
FROM node:22.6.0-alpine AS build

WORKDIR /app

# Copia los archivos necesarios
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto de los archivos del proyecto
COPY . .

# Construye la aplicación
RUN npm run build

# Etapa de producción
FROM node:22.6.0-alpine AS production

WORKDIR /app

# Copia solo los archivos necesarios para correr la aplicación
COPY --from=build /app/build /app/build
COPY package*.json .

# Instala solo las dependencias necesarias para producción
RUN npm install --omit=dev

# Exponer el puerto que utilizará la aplicación
EXPOSE 3001

# Comando para correr la aplicación
CMD ["node", "build"]
