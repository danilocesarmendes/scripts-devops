#!/bin/bash

echo "Verificando Docker Compose..."

# Verificar se já está instalado
if docker compose version &> /dev/null; then
    echo "Docker Compose (plugin) já está instalado!"
    docker compose version
elif command -v docker-compose &> /dev/null; then
    echo "Docker Compose (standalone) já está instalado!"
    docker-compose --version
else
    echo "Instalando Docker Compose..."
    
    # Tentar instalar o plugin primeiro
    if sudo yum install -y docker-compose-plugin; then
        echo "Plugin instalado com sucesso!"
        docker compose version
    else
        echo "Instalação manual..."
        sudo curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
        docker-compose --version
    fi
fi
