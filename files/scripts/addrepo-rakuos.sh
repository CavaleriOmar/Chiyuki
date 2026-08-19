#!/usr/bin/env bash
set -euo pipefail

curl -k -o /tmp/pubkey.gpg https://repo.rakuos.org/pubkey.gpg

sudo rpm --import /tmp/pubkey.gpg

rm /tmp/pubkey.gpg

sudo update-ca-trust extract

sudo dnf reinstall -y ca-certificates

sudo dnf config-manager addrepo --from-repofile=https://repo.rakuos.org/rakuos.repo
