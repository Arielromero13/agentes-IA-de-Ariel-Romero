#!/usr/bin/env bash
set -Eeuo pipefail

REPO_URL="https://github.com/Arielromero13/agentes-IA-de-Ariel-Romero.git"
INSTALL_DIR="${ARIEL_AGENT_OS_DIR:-/opt/ariel-agent-os}"
COMPOSE_FILE="$INSTALL_DIR/deploy/vps/docker-compose.yml"
ENV_FILE="$INSTALL_DIR/deploy/vps/.env"

if [[ "$EUID" -ne 0 ]]; then
  echo "Ejecuta como root usando sudo bash." >&2
  exit 1
fi
if [[ -e "$INSTALL_DIR" ]]; then
  echo "La ruta $INSTALL_DIR ya existe. No modificaré datos ni volúmenes." >&2
  echo "Consulta docs/instalacion-nuevo-vps.md para actualizar una instalación." >&2
  exit 1
fi
if [[ ! -r /etc/os-release ]]; then
  echo "No puedo identificar la distribución del servidor." >&2
  exit 1
fi
. /etc/os-release
if [[ "${ID:-}" != "ubuntu" && "${ID:-}" != "debian" ]]; then
  echo "Este instalador requiere Debian o Ubuntu; detecté: ${PRETTY_NAME:-desconocido}." >&2
  exit 1
fi

if [[ ! -r /dev/tty ]]; then echo "Se requiere una sesión SSH interactiva para ingresar dominio y clave." >&2; exit 1; fi
read -r -p "Dominio que apuntará a este VPS: " CADDY_DOMAIN </dev/tty
if [[ ! "$CADDY_DOMAIN" =~ ^[A-Za-z0-9.-]+$ || "$CADDY_DOMAIN" != *.* || "$CADDY_DOMAIN" == .* || "$CADDY_DOMAIN" == *. ]]; then
  echo "El dominio no parece válido." >&2
  exit 1
fi
read -r -s -p "Clave API de OpenRouter (no se mostrará): " OPENROUTER_API_KEY </dev/tty
printf '\n'
if [[ -z "$OPENROUTER_API_KEY" ]]; then
  echo "La clave API de OpenRouter es obligatoria." >&2
  exit 1
fi

if ! command -v docker >/dev/null 2>&1 || ! docker compose version >/dev/null 2>&1; then
  echo "Instalando Docker Engine y Docker Compose desde el instalador oficial..."
  apt-get update
  DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates curl
  curl -fsSL https://get.docker.com | sh
fi
command -v git >/dev/null 2>&1 || { apt-get update; DEBIAN_FRONTEND=noninteractive apt-get install -y git; }
command -v openssl >/dev/null 2>&1 || { apt-get update; DEBIAN_FRONTEND=noninteractive apt-get install -y openssl; }
docker compose version >/dev/null

echo "Descargando Ariel Agent OS en $INSTALL_DIR..."
git clone --depth 1 "$REPO_URL" "$INSTALL_DIR"

JWT_SECRET="$(openssl rand -hex 32)"
HERMES_API_KEY="$(openssl rand -hex 32)"
cat > "$ENV_FILE" <<EOF
CADDY_DOMAIN=$CADDY_DOMAIN
OPENROUTER_API_KEY=$OPENROUTER_API_KEY
JWT_SECRET=$JWT_SECRET
HERMES_API_KEY=$HERMES_API_KEY
DESKRPG_IMAGE=ghcr.io/dandacompany/deskrpg:2026.1019.1
HERMES_IMAGE=nousresearch/hermes-agent:v0.23.3
EOF
chmod 600 "$ENV_FILE"
unset OPENROUTER_API_KEY

echo "Descargando imágenes y levantando el stack..."
docker compose --env-file "$ENV_FILE" -f "$COMPOSE_FILE" pull
docker compose --env-file "$ENV_FILE" -f "$COMPOSE_FILE" up -d

cat <<EOF

Instalación iniciada.
Oficina: https://$CADDY_DOMAIN
Estado: sudo docker compose --env-file $ENV_FILE -f $COMPOSE_FILE ps
Logs:   sudo docker compose --env-file $ENV_FILE -f $COMPOSE_FILE logs -f hermes deskrpg caddy

En DeskRPG registra el gateway:
  URL: http://hermes:8642
  Token: HERMES_API_KEY guardada en $ENV_FILE

OpenRouter quedó configurado para generación visual con
google/gemini-3.1-flash-image. El modelo conversacional se asigna por empleado.
Revisa docs/instalacion-nuevo-vps.md y valida el stack antes de usarlo.
EOF
