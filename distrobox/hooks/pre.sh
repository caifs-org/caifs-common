#!/bin/sh

# distrobox runs other Linux distributions in containers that share the home
# directory, display and devices of the host. It needs podman or docker.

# Warn when no container manager is present, distrobox cannot start a box without one
check_container_manager() {
    if ! command -v podman > /dev/null 2>&1 && ! command -v docker > /dev/null 2>&1; then
        log_warn "distrobox needs podman or docker. Install one of them first"
    fi
}

arch() {
    check_container_manager
    yay_install distrobox
}

fedora() {
    check_container_manager
    rootdo dnf install -y distrobox
}

debian() {
    check_container_manager
    rootdo apt update
    rootdo apt install -y distrobox
}

ubuntu() {
    debian
}

linux() {
    # The upstream install script puts distrobox and its helpers in <prefix>/bin
    check_container_manager
    curl -fsSL https://raw.githubusercontent.com/89luca89/distrobox/main/install \
        | sh -s -- --prefix "${CAIFS_INSTALL_DIR}"
    caifs_install
}
