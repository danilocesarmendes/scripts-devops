#!/bin/bash

# ============================================
# PARTE 1: REMOVER POSTGRESQL E PGADMIN
# ============================================

echo "=== Removendo PostgreSQL ==="
sudo apt-get --purge remove postgresql postgresql-* -y
sudo apt-get autoremove -y
sudo apt-get autoclean

echo "=== Removendo pgAdmin4 (snap) ==="
sudo snap remove pgadmin4

echo "=== Removendo DBeaver (snap) ==="
sudo snap remove dbeaver-ce

# ============================================
# PARTE 2: LIMPAR PASTAS E CONFIGURAÇÕES
# ============================================

echo "=== Limpando diretórios do PostgreSQL ==="

# Remover diretórios de dados e configuração
sudo rm -rf /var/lib/postgresql/
sudo rm -rf /var/log/postgresql/
sudo rm -rf /etc/postgresql/
sudo rm -rf /etc/postgresql-common/

# Remover binários específicos mencionados
sudo rm -f /usr/bin/pg_dump
sudo rm -rf /usr/lib/postgresql/

# Remover diretórios snap (já foram removidos, mas limpando resíduos)
sudo rm -rf /snap/pgadmin4/
sudo rm -rf /snap/dbeaver-ce/

# Remover diretórios de usuário
rm -rf ~/.postgresql/
rm -rf ~/.pgadmin/

# Limpar repositórios PostgreSQL
sudo rm -f /etc/apt/sources.list.d/pgdg.list

echo "=== Limpeza concluída ==="

# ============================================
# PARTE 3: REINSTALAR POSTGRESQL
# ============================================

echo "=== Instalando PostgreSQL ==="

# Atualizar repositórios
sudo apt-get update

# Adicionar repositório oficial do PostgreSQL
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Adicionar chave GPG
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Atualizar novamente
sudo apt-get update

# Instalar PostgreSQL (versão 17 ou a mais recente disponível)
sudo apt-get install postgresql postgresql-contrib -y

# Verificar status
sudo systemctl status postgresql

echo "=== PostgreSQL instalado ==="

# ============================================
# PARTE 4: REINSTALAR PGADMIN4
# ============================================

echo "=== Instalando pgAdmin4 via snap ==="
sudo snap install pgadmin4

# OU via APT (escolha um método):
# echo "=== Instalando pgAdmin4 via APT ==="
# curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
# sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'
# sudo apt update
# sudo apt install pgadmin4-desktop -y

echo "=== Instalação concluída ==="

# ============================================
# PARTE 5: CONFIGURAÇÃO INICIAL
# ============================================

echo "=== Configurando PostgreSQL ==="

# Acessar postgres e criar usuário (opcional)
echo "Para configurar o PostgreSQL, execute:"
echo "sudo -u postgres psql"
echo ""
echo "Depois execute dentro do psql:"
echo "ALTER USER postgres PASSWORD 'sua_senha';"
echo "CREATE USER seu_usuario WITH PASSWORD 'sua_senha';"
echo "CREATE DATABASE seu_banco OWNER seu_usuario;"
echo "\q"
