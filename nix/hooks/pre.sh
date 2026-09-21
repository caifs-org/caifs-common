#!/bin/sh

# nix - the purely functional package manager
# https://nixos.org/
#
# Arch and Fedora package a current nix with systemd units, build users and
# profile scripts, so this target uses the distro package there.
# Ubuntu 24.04 LTS packages nix 2.18, so Ubuntu uses the upstream installer.
# macOS has no homebrew formula for nix, so it uses the upstream installer too.

arch() {
    yay_install nix
    rootdo systemctl enable --now nix-daemon.socket
}

fedora() {
    rootdo dnf install -y nix nix-daemon
    rootdo systemctl enable --now nix-daemon
}

ubuntu() {
    rootdo apt-get update
    rootdo apt-get install -y curl xz-utils
    generic
}

macos() {
    generic
}

# Multi-user install from the upstream binary tarball. The installer creates
# /nix, adds the nixbld build users, starts the daemon and adds the profile
# script. It calls sudo, so it runs as the target user and not through rootdo.
generic() {
    has_or_exit curl
    curl -sfL https://nixos.org/nix/install -o nix-install.sh
    sh ./nix-install.sh --daemon --yes
}
