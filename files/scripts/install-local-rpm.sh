#!/usr/bin/env bash
set -euo pipefail

sudo dnf install -y ./rpm/plasma-wallpaper-effects-2.1.0-2.1.noarch.rpm \
                    ./rpm/proton-pass-1.39.1-1.x86_64.rpm

sudo rpm -ivh --nodigest --nosignature ./rpm/XPPenLinux4.0.15-260422.rpm
