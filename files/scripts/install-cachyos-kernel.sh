#!/usr/bin/env bash
set -euo pipefail

#   echo "=== ABILITAZIONE REPOSITORY CACHYOS ==="
#   # Esempio basato sul Copr di CachyOS per Fedora
#   dnf copr enable -y bieszczaders/kernel-cachyos

echo "=== SOSTITUZIONE KERNEL ==="
# Rimuove il kernel base e installa i pacchetti CachyOS
dnf swap -y kernel-core kernel-cachyos-core \
    --setopt=install_weak_deps=False

dnf install -y \
    kernel-cachyos-modules \
    kernel-cachyos-devel-matched

# Individua la versione esatta del nuovo kernel installato
NEW_KERNEL_VER=$(rpm -qa "kernel-cachyos-core" --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}\n' | head -n1)

if [ -z "$NEW_KERNEL_VER" ]; then
    echo "ERRORE: Impossibile rilevare la versione del kernel CachyOS!"
    exit 1
fi

echo "Kernel CachyOS rilevato: ${NEW_KERNEL_VER}"

echo "=== GENERAZIONE DIPENDENZE MODULI (depmod) ==="
# Crea manualmente modules.dep per evitare l'errore di dracut
depmod -a "${NEW_KERNEL_VER}"

echo "=== RIGENERAZIONE INITRAMFS (dracut) ==="
# Rigenera l'initramfs per la nuova versione del kernel
dracut --kver "${NEW_KERNEL_VER}" --force /boot/initramfs-"${NEW_KERNEL_VER}".img

echo "=== PULIZIA E DISABILITAZIONE COPR ==="
dnf copr disable -y bieszczaders/kernel-cachyos
dnf clean all
