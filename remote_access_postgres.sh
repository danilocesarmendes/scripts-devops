#!/bin/bash

# ============================================
# CONFIGURAR POSTGRESQL PARA ACESSO REMOTO
# ============================================

echo "=== Configurando PostgreSQL para aceitar conexões remotas ==="

# Encontrar a versão do PostgreSQL instalada
PG_VERSION=$(ls /etc/postgresql/ | head -n 1)
echo "Versão do PostgreSQL detectada: $PG_VERSION"

# Caminhos dos arquivos de configuração
PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"

# ============================================
# PASSO 1: CONFIGURAR postgresql.conf
# ============================================

echo "=== Editando postgresql.conf ==="

# Backup do arquivo original
sudo cp $PG_CONF ${PG_CONF}.backup

# Permitir conexões de todos os IPs
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" $PG_CONF
sudo sed -i "s/listen_addresses = 'localhost'/listen_addresses = '*'/" $PG_CONF

echo "✓ postgresql.conf configurado"

# ============================================
# PASSO 2: CONFIGURAR pg_hba.conf
# ============================================

echo "=== Editando pg_hba.conf ==="

# Backup do arquivo original
sudo cp $PG_HBA ${PG_HBA}.backup

# Adicionar regra para permitir conexões remotas com senha
# OPÇÃO 1: Permitir de qualquer IP (menos seguro)
echo "host    all             all             0.0.0.0/0               md5" | sudo tee -a $PG_HBA
echo "host    all             all             ::/0                    md5" | sudo tee -a $PG_HBA

# OPÇÃO 2: Permitir apenas de um IP específico (mais seguro - descomente se preferir)
# echo "host    all             all             SEU_IP/32               md5" | sudo tee -a $PG_HBA

echo "✓ pg_hba.conf configurado"

# ============================================
# PASSO 3: CONFIGURAR FIREWALL
# ============================================

echo "=== Configurando firewall (UFW) ==="

# Permitir porta 5432 no firewall
sudo ufw allow 5432/tcp

echo "✓ Firewall configurado"

# ============================================
# PASSO 4: REINICIAR POSTGRESQL
# ============================================

echo "=== Reiniciando PostgreSQL ==="
sudo systemctl restart postgresql

# Verificar status
sudo systemctl status postgresql

echo "=== Verificando se PostgreSQL está escutando na porta 5432 ==="
sudo netstat -plnt | grep 5432

echo ""
echo "============================================"
echo "CONFIGURAÇÃO CONCLUÍDA!"
echo "============================================"
echo ""
echo "PostgreSQL agora aceita conexões remotas na porta 5432"
echo ""
echo "⚠️  IMPORTANTE - SEGURANÇA:"
echo "1. Certifique-se de usar senhas fortes"
echo "2. Considere limitar acesso apenas a IPs específicos"
echo "3. Use SSL/TLS para conexões em produção"
echo ""
echo "Para testar a conexão remota:"
echo "psql -h SEU_IP_PUBLICO -U postgres -d nutriaqui"
echo ""
echo "Arquivos de backup criados:"
echo "- ${PG_CONF}.backup"
echo "- ${PG_HBA}.backup"
echo "============================================"
