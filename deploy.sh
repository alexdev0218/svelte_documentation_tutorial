#!/bin/bash

# Ruta del directorio del repositorio
REPO_DIR="/home/fastus/svelte_documentation_tutorial"

# Navegar al directorio del proyecto
cd $REPO_DIR

# Configurar el directorio como seguro para Git
git config --global --add safe.directory $REPO_DIR

# Obtener los últimos cambios del repositorio
echo "Actualizando el repositorio desde GitHub..."
git fetch origin
git reset --hard origin/master # o la rama principal que uses

# Restablecer permisos ejecutables para el script
chmod +x deploy.sh

# Reconstruir y reiniciar los contenedores con docker-compose
echo "Reconstruyendo y reiniciando contenedores Docker..."
docker compose down prod
docker compose up prod -d --build

echo "Despliegue completado con éxito."
