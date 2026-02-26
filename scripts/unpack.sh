#!/bin/bash
# =============================================================
#  Descompacta o dev-toolkit em um repositório
#  Uso: bash unpack.sh [dev-toolkit.tar.gz]
#  Se nenhum arquivo for passado, procura por dev-toolkit.tar.gz no diretório atual
# =============================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info() { echo -e "${GREEN}[✔]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[✘]${NC} $1"; exit 1; }

ARCHIVE="${1:-dev-toolkit.tar.gz}"
TOOLKIT_DIR=".dev-toolkit"

if [ ! -f "$ARCHIVE" ]; then
  error "Arquivo não encontrado: $ARCHIVE"
fi

# Verifica se já existe
if [ -d "$TOOLKIT_DIR" ]; then
  warn "Diretório $TOOLKIT_DIR já existe."
  read -rp "  Sobrescrever? [y/N] " REPLY
  if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    echo "  Cancelado."
    exit 0
  fi
  rm -rf "$TOOLKIT_DIR"
fi

warn "Descompactando ${ARCHIVE}..."
tar xzf "$ARCHIVE"

info "Toolkit extraído em: $TOOLKIT_DIR/"
echo ""
echo "  📂 Conteúdo:"
echo ""

# Mostra o que foi extraído
for dir in "$TOOLKIT_DIR"/*/; do
  DIRNAME=$(basename "$dir")
  COUNT=$(find "$dir" -type f | wc -l)
  echo "    📁 $DIRNAME/ ($COUNT arquivos)"
done

echo ""
echo -e "  ${YELLOW}Dica:${NC} Adicione ${TOOLKIT_DIR}/ ao .gitignore se não quiser versionar."
echo ""
