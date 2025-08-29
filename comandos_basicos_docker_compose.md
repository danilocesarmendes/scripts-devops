# Subir os serviços
docker compose up -d

# Ver status dos containers
docker compose ps

# Ver logs
docker compose logs

# Parar os serviços
docker compose down
  
# Rebuild das imagens
docker compose up --build

# Ver a configuração final
docker compose config

# Sintaxe do Docker Compose v2 (recomendada)
docker compose up
docker compose down
docker compose ps
docker compose logs

# Ou ainda funciona a sintaxe antiga
docker-compose up
docker-compose down
docker-compose ps
docker-compose logs
