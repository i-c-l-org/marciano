#!/bin/bash
# =============================================================
#  Empacota o dev-toolkit para distribuição
#  Uso: npm run pack
#  Output: dev-toolkit.tar.gz (pronto pra copiar em qualquer repo)
# =============================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[✔]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
OUTPUT_FILE="dev-toolkit.tar.gz"
TOOLKIT_DIR=".dev-toolkit"

cd "$ROOT_DIR"

warn "Empacotando dev-toolkit..."

# Cria o tarball com tudo que importa
tar czf "$OUTPUT_FILE" \
  --transform="s,^,${TOOLKIT_DIR}/," \
  docs/ \
  skills/ \
  scripts/ \
  plugins/ \
  README.md \
  2>/dev/null

SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)

info "Pacote criado: ${OUTPUT_FILE} (${SIZE})"
echo ""
echo -e "  ${YELLOW}Para usar em outro repo:${NC}"
echo ""
echo "    1. Copie ${OUTPUT_FILE} para o repo de destino"
echo "    2. Execute:  tar xzf ${OUTPUT_FILE}"
echo "    3. O toolkit estará em .dev-toolkit/"
echo ""
echo -e "  ${YELLOW}Ou com npm (se adicionar ao package.json do destino):${NC}"
echo ""
echo '    "scripts": { "unpack-toolkit": "tar xzf dev-toolkit.tar.gz" }'
echo ""
