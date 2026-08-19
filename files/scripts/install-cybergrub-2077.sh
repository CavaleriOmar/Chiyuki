#!/usr/bin/env bash
set -euo pipefail

# Definisci la destinazione corretta per l'immagine
THEME_DIR="/usr/share/grub/themes/CyberGRUB-2077"

echo "Installazione del tema CyberGRUB 2077..."

# Clona la repository in una cartella temporanea
git clone --depth 1 https://github.com/Kasull-454/CyberGRUB-2077 /tmp/cybergrub

# Crea la cartella di destinazione e copia i file
mkdir -p "$THEME_DIR"
cp -r /tmp/cybergrub/* "$THEME_DIR/"

# Pulizia
rm -rf /tmp/cybergrub

echo "CyberGRUB 2077 installato con successo in $THEME_DIR"
